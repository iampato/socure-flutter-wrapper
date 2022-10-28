package com.example.socure

interface SuccessCallBack {
    fun invoke(data: String)
}

interface ErrorCallBack {
    fun invoke(data: String)
}