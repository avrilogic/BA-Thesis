class JavaJniExperiment {
    private native void print();
    private native String reverse(String input);
    private native int[][] matrixMultiplication(int[][] a, int[][] b);
    private native void printArray(int[][] a);
    public static void main(String[] args) {
        JavaJniExperiment hw = new JavaJniExperiment();
        hw.print();
        System.out.println(hw.reverse("Reverse CPP Method Call!"));

        int[][] a = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        int[][] b = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};
        int[][] c = hw.matrixMultiplication(a, b);
        for (int i = 0; i < c.length; i++) {
            for (int j = 0; j < c[i].length; j++) {
                System.out.print(c[i][j] + "\t");
            }
            System.out.println();
        }

        System.out.println("Printing array from C++");
        hw.printArray(c);
    }
    static {
      System.loadLibrary("cppjnilib");
    }
}

