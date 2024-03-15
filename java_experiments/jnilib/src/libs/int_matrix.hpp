#include <iostream>
#include <vector>
#include <jni.h>
#include <string>
using namespace std;

class IntMatrix
{
protected:
    int **p_matrix = nullptr;
    int rows = 0, cols  = 0;  

public:
    IntMatrix(int rows, int cols) : rows(rows), cols(cols)
    {
        p_matrix = new int *[rows];
        for (int i = 0; i < rows; i++)
        {
            p_matrix[i] = new int[cols];
        }
    }


    ~IntMatrix()
    {
        // cout << "Destructor called" << endl;
        if (p_matrix != nullptr)
        {
            for (int i = 0; i < rows; i++)
            {
                delete[] p_matrix[i];
            }
            delete[] p_matrix;
        }
    }

    int operator()(int i, int j) const
    {
        return p_matrix[i][j];
    }

    int& operator()(int i, int j)
    {
        return p_matrix[i][j];
    }

    int getRows() const
    {
        return rows;
    }

    int getCols() const
    {
        return cols;
    }

    void print()
    {
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                cout << p_matrix[i][j] << "\t";
            }
            cout << endl;
        }
    }



    IntMatrix operator*(const IntMatrix &other)
    {
        if (cols != other.rows)
        {
            throw invalid_argument("Invalid matrix dimensions" + to_string(cols) + " != " + to_string(other.rows));
        }
        IntMatrix result(rows, other.cols);
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < other.cols; j++)
            {
                for (int k = 0; k < cols; k++)
                {
                    result(i, j) += p_matrix[i][k] * other(k, j);
                }
            }
        }
        return result;
    }
};