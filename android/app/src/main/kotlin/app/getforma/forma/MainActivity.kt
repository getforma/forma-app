package app.getforma.forma

import SensorApi
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = SensorApiImplementation.getInstance(this)
        SensorApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)
    }
}
