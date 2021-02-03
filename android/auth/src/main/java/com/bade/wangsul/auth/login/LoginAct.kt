package com.bade.wangsul.auth.login

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.bade.wangsul.auth.R


class LoginAct : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.act_login)

    }

    companion object {
        fun newIntent(context: Context): Intent {
            return Intent(context, LoginAct::class.java)
        }
    }
}