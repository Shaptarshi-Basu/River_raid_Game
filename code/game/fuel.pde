class Fuel {

  int fuel_amount;
  
  Fuel() {
    fuel_amount = 3000;
  }
  
  void update() {
    if (fuel_amount == 0)
      killPlayer();
    fuel_amount--;
  }

  void setFuelToMax() {
    fuel_amount = 5000;
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

void refuel() {
  if ((fuelAmount() + 30) > 5000)
    fuel.setFuelToMax();
  else
    fuel.addFuel(30);
}

void setFuelToMax() {
  fuel.setFuelToMax();
}