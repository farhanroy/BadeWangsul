package com.bade.wangsul

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.bade.wangsul.auth.login.LoginAct
import kotlinx.coroutines.*


class MainAct : AppCompatActivity() {

    private val activityScope = CoroutineScope(Dispatchers.Main)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.act_main)

        toAuth()
    }

    override fun onPause() {
        activityScope.cancel()
        super.onPause()
    }

    private fun toAuth() {
        activityScope.launch {
            delay(2000)
            startActivity(LoginAct.newIntent(this@MainAct))
        }
    }
}