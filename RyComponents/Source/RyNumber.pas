unit RyNumber;

interface

uses
  System.StrUtils, System.SysUtils, System.Classes, Vcl.Dialogs;

type
  TLanguage = (English, Persian);

  TRyNumber = class(TComponent)
  private
    { Private declarations }
    constructor Create(AOwner: TComponent); override;
  protected
    { Protected declarations }
    { Persian }
    function R1_FA(iVal: Integer): string;
    function R2_FA(iVal: Integer): string;
    function R3_FA(iVal: Integer): string;
    function N2L_FA(iVal: Int64): string;
    { English }
    function R1_EN(iVal: Integer): string;
    function R2_EN(iVal: Integer): string;
    function R3_EN(iVal: Integer): string;
    function N2L_EN(iVal: Int64): string;
  public
    { Public declarations }
    function Number2Letter(iVal: Int64; Language: TLanguage): string;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RyConvert', [TRyNumber]);
end;

{ TRyNumber }

constructor TRyNumber.Create(AOwner: TComponent);
begin
  inherited;
end;

// **************************************************************************//
// Persian                                                                   //
// **************************************************************************//
function TRyNumber.R1_FA(iVal: Integer): string;
begin
  Result := '';
  case iVal of
    1:
      Result := 'یک ';
    2:
      Result := 'دو ';
    3:
      Result := 'سه ';
    4:
      Result := 'چهار ';
    5:
      Result := 'پنج ';
    6:
      Result := 'شش ';
    7:
      Result := 'هفت ';
    8:
      Result := 'هشت ';
    9:
      Result := 'نه ';
  else
    Result := '';
  end;
end;

function TRyNumber.R2_FA(iVal: Integer): string;
var
  N1, N10: Integer;
begin
  Result := '';
  if iVal <> 10 then
  begin
    N1 := iVal mod 10;
    N10 := iVal - N1;
  end;
  case iVal of
    10:
      Result := 'ده ';
    11:
      Result := 'یازده ';
    12:
      Result := 'دوازده ';
    13:
      Result := 'سیزده ';
    14:
      Result := 'چهارده ';
    15:
      Result := 'پانزده ';
    16:
      Result := 'شانزده ';
    17:
      Result := 'هفده ';
    18:
      Result := 'هجده ';
    19:
      Result := 'نوزده ';
    20:
      Result := 'بیست ';
    30:
      Result := 'سی ';
    40:
      Result := 'چهل ';
    50:
      Result := 'پنجاه ';
    60:
      Result := 'شصت ';
    70:
      Result := 'هفتاد ';
    80:
      Result := 'هشتاد ';
    90:
      Result := 'نود ';
  else
    Result := R2_FA(N10) + 'و ' + R1_FA(N1)
  end;
end;

function TRyNumber.R3_FA(iVal: Integer): string;
var
  N10, N100: Integer;
begin
  Result := '';
  N10 := iVal mod 100;
  N100 := iVal - N10;
  case iVal of
    100:
      Result := 'یکصد ';
    200:
      Result := 'دویست ';
    300:
      Result := 'سیصد ';
    400:
      Result := 'چهارصد ';
    500:
      Result := 'پانصد ';
    600:
      Result := 'ششصد ';
    700:
      Result := 'هفتصد ';
    800:
      Result := 'هشتصد ';
    900:
      Result := 'نهصد ';
  else
    if N10 >= 10 then
      Result := R3_FA(N100) + 'و ' + R2_FA(N10)
    else
      Result := R3_FA(N100) + 'و ' + R1_FA(N10);
  end;
end;

function TRyNumber.N2L_FA(iVal: Int64): string;
var
  P3D: array [1 .. 5] of Integer;
  Number, N2L: string;
  Temp, TN: Integer;
  I, L, TL: Byte;
begin
  N2L := '';
  for I := 1 to 5 do
    P3D[I] := 0;
  Number := UIntToStr(iVal);
  L := Length(Number);
  I := 0;
  while I < L do
  begin
    I := I + 3;
    Temp := 0;
    Temp := StrToIntDef(LeftStr(RightStr('000' + Number, I), 3), 0);
    P3D[I div 3] := Temp;
  end;

  I := 5;
  while I >= 1 do
  begin
    TN := P3D[I];
    TL := Length(IntToStr(TN));
    case TL of
      1:
        N2L := N2L + R1_FA(TN);
      2:
        N2L := N2L + R2_FA(TN);
      3:
        N2L := N2L + R3_FA(TN);
    end;

    if TN <> 0 then
    begin
      case I of
        1:
          N2L := N2L + '';
        2:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'هزار و '
            else
              N2L := N2L + 'هزار ';
          end;
        3:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'میلیون و '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'میلیون و '
              else
                N2L := N2L + 'میلیون ';
            end;
          end;
        4:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'میلیارد و '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'میلیارد و '
              else
                N2L := N2L + 'میلیارد ';
            end;
          end;
        5:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'تریلیون و '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'تریلیون و '
              else
              begin
                if P3D[I - 3] <> 0 then
                  N2L := N2L + 'تریلیون و '
                else
                  N2L := N2L + 'تریلیون ';
              end;
            end;
          end;
      end;
    end;
    I := I - 1;
  end;
  Result := N2L;
end;

// **************************************************************************//
// English                                                                   //
// **************************************************************************//
function TRyNumber.R1_EN(iVal: Integer): string;
begin
  Result := '';
  case iVal of
    1:
      Result := 'one ';
    2:
      Result := 'two ';
    3:
      Result := 'three ';
    4:
      Result := 'four ';
    5:
      Result := 'five ';
    6:
      Result := 'six ';
    7:
      Result := 'seven ';
    8:
      Result := 'eight ';
    9:
      Result := 'nine ';
  else
    Result := '';
  end;
end;

function TRyNumber.R2_EN(iVal: Integer): string;
var
  N1, N10: Integer;
begin
  Result := '';
  if iVal <> 10 then
  begin
    N1 := iVal mod 10;
    N10 := iVal - N1;
  end;
  case iVal of
    10:
      Result := 'ten ';
    11:
      Result := 'eleven ';
    12:
      Result := 'twelve ';
    13:
      Result := 'thirteen ';
    14:
      Result := 'fourteen ';
    15:
      Result := 'fifteen ';
    16:
      Result := 'sixteen ';
    17:
      Result := 'seventeen ';
    18:
      Result := 'eighteen ';
    19:
      Result := 'nineteen ';
    20:
      Result := 'twenty';
    30:
      Result := 'thirty';
    40:
      Result := 'forty';
    50:
      Result := 'fifty';
    60:
      Result := 'sixty';
    70:
      Result := 'seventy';
    80:
      Result := 'eighty';
    90:
      Result := 'ninety';
  else
    Result := R2_EN(N10) + '-' + R1_EN(N1)
  end;
end;

function TRyNumber.R3_EN(iVal: Integer): string;
var
  N10, N100: Integer;
begin
  Result := '';
  N10 := iVal mod 100;
  N100 := iVal - N10;
  case iVal of
    100:
      Result := 'one hundred ';
    200:
      Result := 'two hundred ';
    300:
      Result := 'three hundred ';
    400:
      Result := 'four hundred ';
    500:
      Result := 'five hundred ';
    600:
      Result := 'six hundred ';
    700:
      Result := 'seven hundred ';
    800:
      Result := 'eight hundred ';
    900:
      Result := 'nine hundred ';
  else
    if N10 >= 10 then
      Result := R3_EN(N100) + '' + R2_EN(N10)
    else
      Result := R3_EN(N100) + '' + R1_EN(N10);
  end;
end;

function TRyNumber.N2L_EN(iVal: Int64): string;
var
  P3D: array [1 .. 5] of Integer;
  Number, N2L: string;
  Temp, TN: Integer;
  I, L, TL: Byte;
begin
  N2L := '';
  for I := 1 to 5 do
    P3D[I] := 0;
  Number := IntToStr(iVal);
  L := Length(Number);
  I := 0;
  while I < L do
  begin
    I := I + 3;
    Temp := 0;
    Temp := StrToIntDef(LeftStr(RightStr('000' + Number, I), 3), 0);
    P3D[I div 3] := Temp;
  end;

  I := 5;
  while I >= 1 do
  begin
    TN := P3D[I];
    TL := Length(IntToStr(TN));
    case TL of
      1:
        N2L := N2L + R1_EN(TN);
      2:
        N2L := N2L + R2_EN(TN);
      3:
        N2L := N2L + R3_EN(TN);
    end;

    if TN <> 0 then
    begin
      case I of
        1:
          N2L := N2L + '';
        2:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'thousand '
            else
              N2L := N2L + 'thousand ';
          end;
        3:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'million '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'million '
              else
                N2L := N2L + 'million ';
            end;
          end;
        4:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'billion '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'billion '
              else
                N2L := N2L + 'billion ';
            end;
          end;
        5:
          begin
            if P3D[I - 1] <> 0 then
              N2L := N2L + 'trillion '
            else
            begin
              if P3D[I - 2] <> 0 then
                N2L := N2L + 'trillion '
              else
              begin
                if P3D[I - 3] <> 0 then
                  N2L := N2L + 'trillion '
                else
                  N2L := N2L + 'trillion ';
              end;
            end;
          end;
      end;
    end;
    I := I - 1;
  end;
  Result := N2L;
end;

function TRyNumber.Number2Letter(iVal: Int64; Language: TLanguage): string;
begin
  Result := '';
  case Language of
    English:
      Result := N2L_EN(iVal);
    Persian:
      Result := N2L_FA(iVal);
  end;
end;

end.
