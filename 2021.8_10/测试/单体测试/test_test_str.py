
from test_str import Car


def test_brake():
    car = Car(66)
    car.brake()
    assert car.speed ==60
