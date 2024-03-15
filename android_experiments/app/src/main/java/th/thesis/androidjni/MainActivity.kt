@file:OptIn(ExperimentalMaterial3Api::class)

package th.thesis.androidjni

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedCard
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import th.thesis.androidjni.ui.theme.AndroidjniTheme
import th.thesis.androidjni.NativeToJNI

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidjniTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier
                            .padding(24.dp)
                            .fillMaxWidth()
                    ) {
                        Title("DEMO Android JNI/NDK APP")
                        ReverseStringContainer()
                        SetWithJNIenv()
                    }

                }
            }
        }
    }
}

@Composable
fun Title(text: String, modifier: Modifier = Modifier) {
    Text(
        text = text,
        fontSize = 24.sp,
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AndroidjniTheme {
        Title("Android")
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ReverseStringContainer() {
    val jniClazz = NativeToJNI();
    var input by remember { mutableStateOf("") }
    OutlinedCard(
        border = BorderStroke(1.dp, Color.Black),
        modifier = Modifier
            .padding(vertical = 16.dp)
            .fillMaxWidth(),
    ) {
        Text(
            text = "Please enter",
            modifier = Modifier
                .padding(16.dp),
        )
        TextField(
            value = input,
            onValueChange = { input = it },
            label = { Text("Input String") },
            modifier = Modifier
                .padding(16.dp),
        )
        Text(
            jniClazz.reverse(input),
            modifier = Modifier
                .padding(16.dp),
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SetWithJNIenv() {
    val jniClazz = NativeToJNI();
    var answer by remember { mutableStateOf(jniClazz.answer) }
    OutlinedCard(
        border = BorderStroke(1.dp, Color.Black),
        modifier = Modifier
            .padding(vertical = 16.dp)
            .fillMaxWidth(),
    ) {
        Text(
            text = "The answer is:",
            modifier = Modifier
                .padding(16.dp),
            textAlign = TextAlign.Center,
        )
        Text(
            text = answer.toString(),
            modifier = Modifier
                .padding(16.dp),
        )
        Button(
            onClick = { jniClazz.provideAnser(); answer = jniClazz.answer },
            modifier = Modifier
                .padding(16.dp),
        ) {
            Text(text = "Please provide answer.")
        }
    }
}