public int max_fuel = 1000;

class Fuel {

  int fuel_amount;
  
  Fuel() {
    fuel_amount = max_fuel;
  }
  
  void update() {
    if (fuel_amount == 0)
      killPlayer();
    else
      fuel_amount--;
  }

  void setFuelToMax() {
    fuel_amount = max_fuel;
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
  if ((fuelAmount() + 20) > max_fuel)
    fuel.setFuelToMax();
  else
    fuel.addFuel(20);
}

void setFuelToMax() {
  fuel.setFuelToMax();
}