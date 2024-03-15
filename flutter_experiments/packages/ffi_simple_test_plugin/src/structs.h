enum CalculationType {
  ADD,
  SUBTRACT,
  MULTIPLY,
  DIVIDE
};

extern "C" struct calculation_request {
  double a;
  double b;
  CalculationType type;
};