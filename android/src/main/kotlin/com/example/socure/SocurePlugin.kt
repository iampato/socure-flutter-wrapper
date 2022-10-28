package com.example.socure

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Base64
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import com.socure.docv.capturesdk.api.SocureDocVHelper
import com.socure.docv.capturesdk.api.SocureDocVHelper.getResult
import com.socure.docv.capturesdk.common.utils.ResultListener
import com.socure.docv.capturesdk.common.utils.ScanError
import com.socure.docv.capturesdk.common.utils.ScannedData
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONException
import org.json.JSONObject


/** SocurePlugin */
class SocurePlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private lateinit var channel: MethodChannel
    private lateinit var act: Activity
    private lateinit var ctx: Context
    private val REQUEST_CODE_FOR_SOCURE = 1999

    private var onSuccessCallback: SuccessCallBack? = null
    private var onErrorCallback: ErrorCallBack? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "socure")
        channel.setMethodCallHandler(this)
        this.ctx = flutterPluginBinding.applicationContext;
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "launchSocure" -> {
                try {
                    val socureSdkKey: String = call.argument("sdkKey")!!
                    var config: String? = call.argument("flow")
                    this.onSuccessCallback = object : SuccessCallBack {
                        override fun invoke(data: String) {
                            result.success(data)
                        }
                    }
                    this.onErrorCallback = object : ErrorCallBack {
                        override fun invoke(data: String) {
                            result.success(data)
                        }
                    }
                    val intent = SocureDocVHelper.getIntent(act, socureSdkKey, config)
                    act.startActivityForResult(intent, REQUEST_CODE_FOR_SOCURE)
                } catch (e: Exception) {
                    result.error("ERROR", "An error occurred when launch socure", e)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?): Boolean {
        if (requestCode == REQUEST_CODE_FOR_SOCURE) {
            intent?.let {
                getResult(intent, object : ResultListener {
                    override fun onSuccess(scannedData: ScannedData) {
//                        Log.d("SOCURE", convertResultToReadableMap(scannedData).toString())
                        onSuccessCallback?.invoke(convertResultToReadableMap(scannedData))
                    }

                    override fun onError(scanError: ScanError) {
//                        Log.d("SOCURE", convertErrorToReadableMap(scanError).toString())
                        onErrorCallback?.invoke(convertErrorToReadableMap(scanError))
                    }
                })
            }
            return true
        }
        return false
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.act = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onDetachedFromActivity() {}

    // helpers
    private fun convertResultToReadableMap(scannedData: ScannedData): String {
        val docVResponse = LinkedHashMap<String, Any?>()
        docVResponse["docUUID"] = scannedData.docUUID
        docVResponse["sessionId"] = scannedData.sessionId

        val captureData = LinkedHashMap<String, Any?>()
        scannedData.captureData?.forEach {
            captureData[it.key] = it.value
        }
        docVResponse["captureData"] = captureData

        val capturedImages = LinkedHashMap<String, Any?>()
        scannedData.capturedImages?.forEach {
            capturedImages[it.key] = Base64.encodeToString(it.value, Base64.DEFAULT) ?: ""
        }
        docVResponse["capturedImages"] = capturedImages

        scannedData.extractedData?.let { jsonString ->
            try {
                docVResponse["extractedData"] = convertStringToMap(JSONObject(jsonString))
            } catch (ex: JSONException) {
                docVResponse["extractedData"] = jsonString
            }
        }
        return JSONObject(docVResponse).toString()
    }

    private fun convertErrorToReadableMap(scanError: ScanError): String {
        val docVErrResponse = LinkedHashMap<String, Any?>()
        docVErrResponse["statusCode"] = scanError.statusCode.toString()
        docVErrResponse["errorMessage"] = scanError.errorMessage
        scanError.sessionId?.let {
            docVErrResponse["sessionId"] = it
        }

        val capturedImages = LinkedHashMap<String, Any?>()
        scanError.capturedImages?.forEach {
            capturedImages[it.key] = Base64.encodeToString(it.value, Base64.DEFAULT) ?: ""
        }
        docVErrResponse["capturedImages"] = capturedImages
        return JSONObject(docVErrResponse).toString()
    }

    private fun convertStringToMap(jsonObject: JSONObject): Map<String, Any?> {
        val responseMap = LinkedHashMap<String, Any?>()
        val jsonIterator = jsonObject.keys()
        while (jsonIterator.hasNext()) {
            val key: String = jsonIterator.next()
            when (val value = jsonObject[key]) {
                is JSONObject -> {
                    responseMap[key] = convertStringToMap(value)
                }
                is String -> {
                    responseMap[key] = value
                }
            }
        }
        return responseMap.toMap()
    }

}
