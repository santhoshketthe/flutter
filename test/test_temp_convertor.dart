import 'dart:math';

import 'package:flutter_project/testing_temperature_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final convertor = TemperatureConvertor();

  group('TemperatureConvertor', (){
    test('celsiusToFahrenheit', (){
      expect(convertor.celsiusTOFahrenheit(0), 32);
      expect(convertor.celsiusTOFahrenheit(100), 212);
      expect(convertor.celsiusTOFahrenheit(-40), -40);
    });

    test('fahrenheitToCelsius', (){
       expect(convertor.fahrenheitToCelsius(32),0 );
       expect(convertor.fahrenheitToCelsius(212), 100);
       expect(convertor.fahrenheitToCelsius(-40), -40);
    });
  });
}