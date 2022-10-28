package com.example.socure

interface SuccessCallBack {
    fun invoke(data: Map<String, Any?>)
}

interface ErrorCallBack {
    fun invoke(data: Map<String, Any?>)
}