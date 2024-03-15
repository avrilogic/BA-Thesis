#include "int_matrix.hpp"
#include <jni.h>

class ExtIntMatrix : public IntMatrix
{
public:
  ExtIntMatrix(const IntMatrix &matrix) : IntMatrix(matrix.getRows(), matrix.getCols())
  {
    // copy data because cast to ExtIntMatrix will call destructor of IntMatrix
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        p_matrix[i][j] = matrix(i, j);
      }
    }
  }

  ExtIntMatrix(JNIEnv *env, jobjectArray in) : IntMatrix(0, 0)
  {
    rows = env->GetArrayLength(in);
    p_matrix = new int *[rows];
    for (int i = 0; i < rows; i++)
    {
      jintArray row = (jintArray)env->GetObjectArrayElement(in, i);
      int innerSize = env->GetArrayLength(row);
      if (cols == 0)
      {
        cols = innerSize;
      }
      else if (cols != innerSize)
      {
        throw invalid_argument("Inconsistent matrix dimensions");
      }

      jint *rowInner = env->GetIntArrayElements(row, 0);

      p_matrix[i] = new int[innerSize];
      for (int j = 0; j < innerSize; j++)
      {
        p_matrix[i][j] = rowInner[j];
      }

      env->ReleaseIntArrayElements(row, rowInner, 0);
      env->DeleteLocalRef(row);
    }
  }

  jobjectArray toJObjectArray(JNIEnv *env)
  {
    jobjectArray result = env->NewObjectArray(rows, env->FindClass("[I"), NULL);
    for (int i = 0; i < rows; i++)
    {
      jintArray row = env->NewIntArray(cols);
      env->SetIntArrayRegion(row, 0, cols, reinterpret_cast<const jint *>(p_matrix[i]));
      env->SetObjectArrayElement(result, i, row);
      env->DeleteLocalRef(row);
    }
    return result;
  }

  ExtIntMatrix operator*(const IntMatrix &other)
  {
    IntMatrix result = IntMatrix::operator*(other);
    return ExtIntMatrix(result);
  }
};