unit RyTemperature;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs;

type
  TRyTemperature = class(TComponent)
  private
    { Private declarations }
    constructor Create(AOwner: TComponent); override;
  protected
    { Protected declarations }
  public
    { Public declarations }
    function CelsiusToFahrenheit(Celsius: Real): Real;
    function FahrenheitToCelsius(Fahrenheit: Real): Real;
    function KelvinToCelsius(Kelvin: Real): Real;
    function CelsiusToKelvin(Celsius: Real): Real;
    function FahrenheitToKelvin(Fahrenheit: Real): Real;
    function KelvinToFahrenheit(Kelvin: Real): Real;
    function KelvinToRankine(Kelvin: Real): Real;
    function RankineToKelvin(Rankine: Real): Real;
    function CelsiusToRankine(Celsius: Real): Real;
    function RankineToCelsius(Rankine: Real): Real;
    function FahrenheitToRankine(Fahrenheit: Real): Real;
    function RankineToFahrenheit(Rankine: Real): Real;

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RyConvert', [TRyTemperature]);
end;

{ TRyTemperature }

constructor TRyTemperature.Create(AOwner: TComponent);
begin
  inherited;
end;

function TRyTemperature.CelsiusToFahrenheit(Celsius: Real): Real;
begin
  Result := (Celsius * (9 / 5)) + 32
end;

function TRyTemperature.FahrenheitToCelsius(Fahrenheit: Real): Real;
begin
  Result := (Fahrenheit - 32) * (5 / 9);
end;

function TRyTemperature.KelvinToCelsius(Kelvin: Real): Real;
begin
  Result := Kelvin - 273.15;
end;

function TRyTemperature.CelsiusToKelvin(Celsius: Real): Real;
begin
  Result := Celsius + 273.15;
end;

function TRyTemperature.FahrenheitToKelvin(Fahrenheit: Real): Real;
begin
  Result := (Fahrenheit + 459.67) * (5 / 9);
end;

function TRyTemperature.KelvinToFahrenheit(Kelvin: Real): Real;
begin
  Result := Kelvin * (9 / 5) - 459.67;
end;

function TRyTemperature.KelvinToRankine(Kelvin: Real): Real;
begin
  Result := Kelvin * (9 / 5);
end;

function TRyTemperature.RankineToKelvin(Rankine: Real): Real;
begin
  Result := Rankine * (5 / 9);
end;

function TRyTemperature.CelsiusToRankine(Celsius: Real): Real;
begin
  Result := Celsius * (9 / 5) + 491.67
end;

function TRyTemperature.RankineToCelsius(Rankine: Real): Real;
begin
  Result := (Rankine - 491.67) * (5 / 9);
end;

function TRyTemperature.FahrenheitToRankine(Fahrenheit: Real): Real;
begin
  Result := Fahrenheit + 459.67;
end;

function TRyTemperature.RankineToFahrenheit(Rankine: Real): Real;
begin
  Result := Rankine - 459.67;
end;

end.
