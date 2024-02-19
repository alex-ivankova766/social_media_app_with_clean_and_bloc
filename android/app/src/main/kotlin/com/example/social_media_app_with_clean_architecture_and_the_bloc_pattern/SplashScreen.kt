package com.example.social_media_app_with_clean_architecture_and_the_bloc_pattern


import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.view.View
import android.view.animation.Animation
import android.view.animation.AnimationSet
import android.view.animation.AnimationUtils
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity


class SplashScreen : AppCompatActivity() {
   override fun onCreate(savedInstanceState: Bundle?) {
       super.onCreate(savedInstanceState)

       setContentView(R.layout.activity_splash_screen)

       val cosmo: ImageView = findViewById(R.id.Cosmo)
       cosmo.visibility = View.INVISIBLE
       val sun: ImageView = findViewById(R.id.Sun)

       val rotateAnimation = AnimationUtils.loadAnimation(this, R.anim.triple_rotate)
       val opacityAnimation = AnimationUtils.loadAnimation(this, R.anim.opacity_up_and_slide)
       val scaleUpAnimationWithRotate = AnimationUtils.loadAnimation(this, R.anim.transform_scale_and_opacity)

       val rotateDuration : Long = 1000
       val opacityDuration : Long = 2000
       val scaleUpDuration : Long = 2000

       val totalAnimationDuration : Long = rotateDuration + opacityDuration + scaleUpDuration


       scaleUpAnimationWithRotate.setAnimationListener(object : Animation.AnimationListener {
           override fun onAnimationStart(animation: Animation) {
           }

           override fun onAnimationEnd(animation: Animation) {
               sun.startAnimation(rotateAnimation)
               cosmo.visibility = View.VISIBLE
               cosmo.startAnimation(opacityAnimation)
           }

           override fun onAnimationRepeat(animation: Animation) {
           }
       })
       sun.startAnimation(scaleUpAnimationWithRotate)


       Handler().postDelayed({
           val intent = Intent(this, MainActivity::class.java)
           startActivity(intent)
           finish()
       }, totalAnimationDuration)
   }
}