#include "JavaJniExperiment.h"
#include <iostream>
#include  "ext_int_matrix.hpp"
using namespace std;

JNIEXPORT void JNICALL Java_JavaJniExperiment_print(JNIEnv *, jobject)
{
    cout << "Hello, World from C++!" << endl;
}

JNIEXPORT jstring JNICALL Java_JavaJniExperiment_reverse(JNIEnv *env, jobject, jstring input)
{

    const char *str = env->GetStringUTFChars(input, 0);
    int len = env->GetStringLength(input);
    char *buf = new char[len + 1];
    for (int i = 0; i < len; i++)
    {
        buf[i] = str[len - i - 1];
    }
    buf[len] = 0; // null-terminate the string
    env->ReleaseStringUTFChars(input, str);
    return env->NewStringUTF(buf);
}

JNIEXPORT jobjectArray JNICALL Java_JavaJniExperiment_matrixMultiplication(JNIEnv *env, jobject, jobjectArray a, jobjectArray b)
{
    ExtIntMatrix A(env, a);
    ExtIntMatrix B(env, b);
    ExtIntMatrix C = A * B;

    return C.toJObjectArray(env);
}

JNIEXPORT void JNICALL Java_JavaJniExperiment_printArray
  (JNIEnv *env, jobject, jobjectArray in)
  {
    ExtIntMatrix A(env, in);
    A.print();
    return;
  }