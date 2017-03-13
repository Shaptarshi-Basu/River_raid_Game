class Fuel {

  int fuel_amount;
  
  Fuel() {
    fuel_amount = 10000;
  }
  
  void update() {
    if (fuel_amount == 0)
      return;
    fuel_amount--;
  }

  void addFuel(int amount) {
    fuel_amount += amount;
  }

  int getFuel() {
    return fuel_amount;
  }
}

public Fuel fuel;

void initFuel() {
  fuel = new Fuel();
}

void updateFuel() {
  fuel.update();
}

int fuelAmount() {
  return fuel.getFuel();
}