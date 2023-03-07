unit RyDate;

interface

uses
  System.StrUtils, System.SysUtils, System.Classes, System.DateUtils,
  Vcl.Dialogs;

type
  TCalendarType = (Gregorian, Jalali);

  TRyDate = class(TComponent)
  private
    { Private declarations }
    constructor Create(AOwner: TComponent); override;
  protected
    { Protected declarations }
  public
    { Public declarations }
    { Leap Year Checking }
    function IsGregorianLeapYear(GregorianYear: word): Boolean;
    function IsJalaliLeapYear(JalaliYear: word): Boolean;

    { Gregorian/Jalali date convert }
    function Gregorian2Jalali(GregorianDate: TDateTime): string; overload;
    function Gregorian2Jalali(GregorianYear, GregorianMonth, GregorianDay: word)
      : string; overload;
    function Jalali2Gregorian(JalaliDate: string): TDate; overload;
    function Jalali2Gregorian(JalaliYear, JalaliMonth, JalaliDay: word)
      : TDate; overload;

    { Days in Jalali Year }
    function JalaliDaysInYear(JalaliYear, JalaliMonth, JalaliDay: word)
      : word; overload;
    function JalaliDaysInYear(JalaliDate: string): word; overload;

    { Jalali Today }
    function JalaliTodayShortDate: string;
    function JalaliTodayLongDate: string;

    {
      function JalaliWeeksInYear(JalaliYear, JalaliMonth, JalaliDay: Integer)
      : Byte; overload;
      function JalaliWeeksInYear(JalaliDate: string): Byte; overload;
    }

    { Increment/Decrement Jalali Date fields }
    function JalaliIncYear(JalaliYear, JalaliMonth, JalaliDay: word;
      NumberOfYear: Integer): string; overload;
    function JalaliIncYear(JalaliDate: string; NumberOfYear: Integer)
      : string; overload;
    function JalaliIncMonth(JalaliYear, JalaliMonth, JalaliDay: word;
      NumberOfMonth: Integer): string; overload;
    function JalaliIncMonth(JalaliDate: string; NumberOfMonth: Integer)
      : string; overload;
    function JalaliIncDay(JalaliYear, JalaliMonth, JalaliDay: word;
      NumberOfDay: Integer): string; overload;
    function JalaliIncDay(JalaliDate: string; NumberOfDay: Integer)
      : string; overload;
    function JalaliIncWeek(JalaliYear, JalaliMonth, JalaliDay: word;
      NumberOfWeek: Integer): string; overload;
    function JalaliIncWeek(JalaliDate: string; NumberOfWeek: Integer)
      : string; overload;

    { Jalali Day Name }
    function JalaliDateDayName(JalaliYear, JalaliMonth, JalaliDay: word)
      : string; overload;
    function JalaliDateDayName(JalaliDate: string): string; overload;

    { Jalali Month Name }
    function JalaliMonthName(JalaliMonth: word): string; overload;
    function JalaliMonthName(JalaliDate: string): string; overload;

    { Jalali Year Name }
    function JalaliYearName(JalaliYear: word): string; overload;
    function JalaliYearName(JalaliDate: string): string; overload;

    { First/Last Day of Jalali Year }
    function JalaliFirstDayNameOfYear(JalaliYear: word): string;
    function JalaliLastDayNameOfYear(JalaliYear: word): string;

    { Yesterday/Tomorrow Jalali Date }
    function JalaliYesterday(JalaliYear, JalaliMonth, JalaliDay: word)
      : string; overload;
    function JalaliYesterday(JalaliDate: string): string; overload;
    function JalaliYesterdayName(JalaliYear, JalaliMonth, JalaliDay: word)
      : string; overload;
    function JalaliYesterdayName(JalaliDate: string): string; overload;
    function JalaliTomorrow(JalaliYear, JalaliMonth, JalaliDay: word)
      : string; overload;
    function JalaliTomorrow(JalaliDate: string): string; overload;
    function JalaliTomorrowName(JalaliYear, JalaliMonth, JalaliDay: word)
      : string; overload;
    function JalaliTomorrowName(JalaliDate: string): string; overload;

    { Jalali Date Diff }
    function JalaliYearSpan(JalaliStartDate, JalaliEndDate: string): Double;
    function JalaliMonthSpan(JalaliStartDate, JalaliEndDate: string): Double;
    function JalaliDaySpan(JalaliStartDate, JalaliEndDate: string): Double;
    function JalaliWeekSpan(JalaliStartDate, JalaliEndDate: string): Double;

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RyConvert', [TRyDate]);
end;

{ TRyDate }

constructor TRyDate.Create(AOwner: TComponent);
begin
  inherited;
end;

// **************************************************************************//
// Leap Year Checking                                                        //
// **************************************************************************//
function TRyDate.IsGregorianLeapYear(GregorianYear: word): Boolean;
begin
  if ((GregorianYear mod 4) = 0) and
    (((GregorianYear mod 100) <> 0) or ((GregorianYear mod 400) = 0)) then
    Result := True
  else
    Result := False;
end;

function TRyDate.IsJalaliLeapYear(JalaliYear: word): Boolean;
var
  LeapSet: set of Byte;
begin
  LeapSet := [1, 5, 9, 13, 17, 22, 26, 30];
  if (JalaliYear mod 33) in LeapSet then
    Result := True
  else
    Result := False;
end;

// **************************************************************************//
// Days in Jalali Year                                                       //
// **************************************************************************//
function TRyDate.JalaliDaysInYear(JalaliYear, JalaliMonth,
  JalaliDay: word): word;
var
  iDays: word;
begin
  iDays := 0;
  if JalaliMonth <= 6 then
    iDays := (JalaliMonth * 31) + JalaliDay
  else
    iDays := 186 + ((JalaliMonth - 6 - 1) * 30) + JalaliDay;
  Result := iDays;
end;

function TRyDate.JalaliDaysInYear(JalaliDate: string): word;
var
  Y, M, D: word;
begin
  Result := 0;
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliDaysInYear(Y, M, D);
end;

// **************************************************************************//
// Jalali Today                                                              //
// **************************************************************************//
function TRyDate.JalaliTodayShortDate: string;
begin
  Result := Gregorian2Jalali(now);
end;

function TRyDate.JalaliTodayLongDate: string;
var
  sTemp: string;
begin
  Result := '';
  sTemp := Gregorian2Jalali(now);
  Result := JalaliDateDayName(sTemp) + ' ' + RightStr(sTemp, 2) + ' ' +
    JalaliMonthName(sTemp) + ' ' + LeftStr(sTemp, 4);
end;

// **************************************************************************//
// Increment/Decrement Jalali Date fields                                    //
// **************************************************************************//
function TRyDate.JalaliIncYear(JalaliYear, JalaliMonth, JalaliDay: word;
  NumberOfYear: Integer): string;
begin
  Result := '';
  Result := Gregorian2Jalali(IncYear(Jalali2Gregorian(JalaliYear, JalaliMonth,
    JalaliDay), NumberOfYear));
end;

function TRyDate.JalaliIncYear(JalaliDate: string;
  NumberOfYear: Integer): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliIncYear(Y, M, D, NumberOfYear);
end;

function TRyDate.JalaliIncMonth(JalaliYear, JalaliMonth, JalaliDay: word;
  NumberOfMonth: Integer): string;
begin
  Result := '';
  Result := Gregorian2Jalali(IncMonth(Jalali2Gregorian(JalaliYear, JalaliMonth,
    JalaliDay), NumberOfMonth));
end;

function TRyDate.JalaliIncMonth(JalaliDate: string;
  NumberOfMonth: Integer): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliIncMonth(Y, M, D, NumberOfMonth);
end;

function TRyDate.JalaliIncDay(JalaliYear, JalaliMonth, JalaliDay: word;
  NumberOfDay: Integer): string;
begin
  Result := '';
  Result := Gregorian2Jalali(IncDay(Jalali2Gregorian(JalaliYear, JalaliMonth,
    JalaliDay), NumberOfDay));
end;

function TRyDate.JalaliIncDay(JalaliDate: string; NumberOfDay: Integer): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliIncDay(Y, M, D, NumberOfDay);
end;

function TRyDate.JalaliIncWeek(JalaliYear, JalaliMonth, JalaliDay: word;
  NumberOfWeek: Integer): string;
begin
  Result := '';
  Result := Gregorian2Jalali(IncWeek(Jalali2Gregorian(JalaliYear, JalaliMonth,
    JalaliDay), NumberOfWeek));
end;

function TRyDate.JalaliIncWeek(JalaliDate: string;
  NumberOfWeek: Integer): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliIncWeek(Y, M, D, NumberOfWeek);
end;

// **************************************************************************//
// Jalali Day Name                                                           //
// **************************************************************************//
function TRyDate.JalaliDateDayName(JalaliYear, JalaliMonth,
  JalaliDay: word): string;
begin
  case DayOfTheWeek(Jalali2Gregorian(JalaliYear, JalaliMonth, JalaliDay)) of
    1:
      Result := 'دوشنبه';
    2:
      Result := 'سه شنبه';
    3:
      Result := 'چهارشنبه';
    4:
      Result := 'پنجشنبه';
    5:
      Result := 'جمعه';
    6:
      Result := 'شنبه';
    7:
      Result := 'یکشنبه';
  else
    Result := '';
  end;
end;

function TRyDate.JalaliDateDayName(JalaliDate: string): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliDateDayName(Y, M, D);
end;

// **************************************************************************//
// Jalali Month Name                                                         //
// **************************************************************************//
function TRyDate.JalaliMonthName(JalaliMonth: word): string;
begin
  case JalaliMonth of
    1:
      Result := 'فروردین';
    2:
      Result := 'اردیبهشت';
    3:
      Result := 'خرداد';
    4:
      Result := 'تیر';
    5:
      Result := 'مرداد';
    6:
      Result := 'شهریور';
    7:
      Result := 'مهر';
    8:
      Result := 'آبان';
    9:
      Result := 'آذر';
    10:
      Result := 'دی';
    11:
      Result := 'بهمن';
    12:
      Result := 'اسفند';
  else
    Result := '';
  end;
end;

function TRyDate.JalaliMonthName(JalaliDate: string): string;
var
  M: word;
begin
  Result := '';
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  Result := JalaliMonthName(M);
end;

// **************************************************************************//
// Jalali Year Name                                                         //
// **************************************************************************//
function TRyDate.JalaliYearName(JalaliYear: word): string;
begin
  case (JalaliYear mod 12) of
    0:
      Result := 'مار';
    1:
      Result := 'اسب';
    2:
      Result := 'گوسفند';
    3:
      Result := 'میمون';
    4:
      Result := 'مرغ';
    5:
      Result := 'سگ';
    6:
      Result := 'خوک';
    7:
      Result := 'موش';
    8:
      Result := 'گاو';
    9:
      Result := 'پلنگ';
    10:
      Result := 'خرگوش';
    11:
      Result := 'نهنگ';
  else
    Result := '';
  end;
end;

function TRyDate.JalaliYearName(JalaliDate: string): string;
var
  Y: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  Result := JalaliYearName(Y);
end;

// **************************************************************************//
// Jalali Date Diff                                                          //
// **************************************************************************//
function TRyDate.JalaliYearSpan(JalaliStartDate, JalaliEndDate: string): Double;
begin
  Result := YearSpan(Jalali2Gregorian(JalaliStartDate),
    Jalali2Gregorian(JalaliEndDate));
end;

function TRyDate.JalaliMonthSpan(JalaliStartDate, JalaliEndDate
  : string): Double;
begin
  Result := MonthSpan(Jalali2Gregorian(JalaliStartDate),
    Jalali2Gregorian(JalaliEndDate));
end;

function TRyDate.JalaliWeekSpan(JalaliStartDate, JalaliEndDate: string): Double;
begin
  Result := WeekSpan(Jalali2Gregorian(JalaliStartDate),
    Jalali2Gregorian(JalaliEndDate));
end;

function TRyDate.JalaliDaySpan(JalaliStartDate, JalaliEndDate: string): Double;
begin
  Result := DaySpan(Jalali2Gregorian(JalaliStartDate),
    Jalali2Gregorian(JalaliEndDate));
end;

// **************************************************************************//
// First/Last Day of Jalali Year                                             //
// **************************************************************************//
function TRyDate.JalaliFirstDayNameOfYear(JalaliYear: word): string;
begin
  Result := JalaliDateDayName(JalaliYear, 1, 1);
end;

function TRyDate.JalaliLastDayNameOfYear(JalaliYear: word): string;
begin
  if IsJalaliLeapYear(JalaliYear) then
    Result := JalaliDateDayName(JalaliYear, 12, 30)
  else
    Result := JalaliDateDayName(JalaliYear, 12, 29);
end;

// **************************************************************************//
// Yesterday/Tomorrow Jalali Date                                            //
// **************************************************************************//
function TRyDate.JalaliTomorrow(JalaliYear, JalaliMonth,
  JalaliDay: word): string;
begin
  Result := '';
  Result := JalaliIncDay(JalaliYear, JalaliMonth, JalaliDay, 1);
end;

function TRyDate.JalaliTomorrow(JalaliDate: string): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliTomorrow(Y, M, D);
end;

function TRyDate.JalaliTomorrowName(JalaliYear, JalaliMonth,
  JalaliDay: word): string;
begin
  Result := JalaliDateDayName(JalaliTomorrow(JalaliYear, JalaliMonth,
    JalaliDay));
end;

function TRyDate.JalaliTomorrowName(JalaliDate: string): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliTomorrowName(Y, M, D);
end;

function TRyDate.JalaliYesterday(JalaliYear, JalaliMonth,
  JalaliDay: word): string;
begin
  Result := '';
  Result := JalaliIncDay(JalaliYear, JalaliMonth, JalaliDay, -1);
end;

function TRyDate.JalaliYesterday(JalaliDate: string): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliYesterday(Y, M, D);
end;

function TRyDate.JalaliYesterdayName(JalaliYear, JalaliMonth,
  JalaliDay: word): string;
begin
  Result := JalaliDateDayName(JalaliYesterday(JalaliYear, JalaliMonth,
    JalaliDay));
end;

function TRyDate.JalaliYesterdayName(JalaliDate: string): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := JalaliYesterdayName(Y, M, D);
end;

// **************************************************************************//
// Gregorian to Jalali                                                       //
// **************************************************************************//
function TRyDate.Gregorian2Jalali(GregorianDate: TDateTime): string;
var
  Y, M, D: word;
begin
  Result := '';
  Y := YearOf(GregorianDate);
  M := MonthOf(GregorianDate);
  D := DayOf(GregorianDate);
  Result := Gregorian2Jalali(Y, M, D);
end;

function TRyDate.Gregorian2Jalali(GregorianYear, GregorianMonth,
  GregorianDay: word): string;
var
  I, DayOfYear, M: Integer;
  GMonthDays: array [1 .. 12] of Byte;
begin
  Result := '';
  GMonthDays[1] := 31;
  GMonthDays[2] := 28;
  GMonthDays[3] := 31;
  GMonthDays[4] := 30;
  GMonthDays[5] := 31;
  GMonthDays[6] := 30;
  GMonthDays[7] := 31;
  GMonthDays[8] := 31;
  GMonthDays[9] := 30;
  GMonthDays[10] := 31;
  GMonthDays[11] := 30;
  GMonthDays[12] := 31;
  DayOfYear := 0;
  I := 1;

  { Special Years }
  if ((GregorianYear mod 400) = 384) then
    M := 1
  else
    M := 0;
  GregorianDay := GregorianDay - M;
  if GregorianDay = 0 then
  begin
    GregorianMonth := GregorianMonth - 1;
    if GregorianMonth = 0 then
    begin
      GregorianYear := GregorianYear - 1;
      GregorianMonth := 12;
    end;
    GregorianDay := GMonthDays[GregorianMonth];
  end;

  { Day of Year }
  while I < GregorianMonth do
  begin
    DayOfYear := DayOfYear + GMonthDays[I];
    I := I + 1;
  end;
  DayOfYear := DayOfYear + GregorianDay;
  if IsGregorianLeapYear(GregorianYear) and (GregorianMonth > 2) then
    DayOfYear := DayOfYear + 1;

  { Month and Day }
  if DayOfYear <= 79 then
  begin
    if ((GregorianYear - 1) mod 4) = 0 then
      DayOfYear := DayOfYear + 11
    else
      DayOfYear := DayOfYear + 10;
    GregorianYear := GregorianYear - 622;

    if (DayOfYear mod 30) = 0 then
    begin
      GregorianMonth := (DayOfYear div 30) + 9;
      GregorianDay := 30;
    end
    else
    begin
      GregorianMonth := (DayOfYear div 30) + 10;
      GregorianDay := DayOfYear mod 30;
    end;
  end
  else
  begin
    GregorianYear := GregorianYear - 621;
    DayOfYear := DayOfYear - 79;
    if DayOfYear <= 186 then
    begin
      if (DayOfYear mod 31) = 0 then
      begin
        GregorianMonth := DayOfYear div 31;
        GregorianDay := 31;
      end
      else
      begin
        GregorianMonth := (DayOfYear div 31) + 1;
        GregorianDay := DayOfYear mod 31;
      end;
    end
    else
    begin
      DayOfYear := DayOfYear - 186;
      if (DayOfYear mod 30) = 0 then
      begin
        GregorianMonth := (DayOfYear div 30) + 6;
        GregorianDay := 30;
      end
      else
      begin
        GregorianMonth := (DayOfYear div 30) + 7;
        GregorianDay := DayOfYear mod 30;
      end;
    end;
  end;
  Result := IntToStr(GregorianYear) + '/' +
    RightStr('00' + IntToStr(GregorianMonth), 2) + '/' +
    RightStr('00' + IntToStr(GregorianDay), 2);
end;

// **************************************************************************//
// Jalali to Gregorian                                                       //
// **************************************************************************//
function TRyDate.Jalali2Gregorian(JalaliDate: string): TDate;
var
  Y, M, D: word;
begin
  Result := now;
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);
  Result := Jalali2Gregorian(Y, M, D);
end;

function TRyDate.Jalali2Gregorian(JalaliYear, JalaliMonth,
  JalaliDay: word): TDate;
  function CheckLeap(iValue: Integer; Leap: Boolean): Byte;
  begin
    if (iValue = 1) and (Leap) then
      Result := 1
    else
      Result := 0;
  end;

var
  GDayInMonth: array [1 .. 12] of Byte;
  JDayInMonth: array [1 .. 12] of Byte;
  JYear, JMonth, JDay: word;
  GYear, GMonth, GDay: word;
  JDayNo, GDayNo: Int64;
  I: Integer;
  Leap: Boolean;
begin
  Result := now;
  GDayInMonth[1] := 31;
  GDayInMonth[2] := 28;
  GDayInMonth[3] := 31;
  GDayInMonth[4] := 30;
  GDayInMonth[5] := 31;
  GDayInMonth[6] := 30;
  GDayInMonth[7] := 31;
  GDayInMonth[8] := 31;
  GDayInMonth[9] := 30;
  GDayInMonth[10] := 31;
  GDayInMonth[11] := 30;
  GDayInMonth[12] := 31;

  JDayInMonth[1] := 31;
  JDayInMonth[2] := 31;
  JDayInMonth[3] := 31;
  JDayInMonth[4] := 31;
  JDayInMonth[5] := 31;
  JDayInMonth[6] := 31;
  JDayInMonth[7] := 30;
  JDayInMonth[8] := 30;
  JDayInMonth[9] := 30;
  JDayInMonth[10] := 30;
  JDayInMonth[11] := 30;
  JDayInMonth[12] := 29;

  JYear := JalaliYear - 979;
  JMonth := JalaliMonth - 1;
  JDay := JalaliDay - 1;
  JDayNo := 365 * JYear + (JYear div 33) * 8 + (((JYear mod 33) + 3) div 4);
  I := 1;
  while I <= JMonth do
  begin
    JDayNo := JDayNo + JDayInMonth[I];
    I := I + 1;
  end;

  JDayNo := JDayNo + JDay;
  GDayNo := JDayNo + 79;
  GYear := 1600 + 400 * (GDayNo div 146097);
  GDayNo := GDayNo mod 146097;

  Leap := True;
  if GDayNo >= 36525 then
  begin
    GDayNo := GDayNo - 1;
    GYear := GYear + 100 * (GDayNo div 36524);
    GDayNo := GDayNo mod 36524;
    if GDayNo >= 365 then
      GDayNo := GDayNo + 1
    else
      Leap := False;
  end;

  GYear := GYear + 4 * (GDayNo div 1461);
  GDayNo := GDayNo mod 1461;
  if GDayNo >= 366 then
  begin
    Leap := False;
    GDayNo := GDayNo - 1;
    GYear := GYear + (GDayNo div 365);
    GDayNo := GDayNo mod 365;
  end;

  { GDayNo is incorrect }
  I := 0;
  while GDayNo >= (GDayInMonth[I + 1] + CheckLeap(I, Leap)) do
  begin
    GDayNo := GDayNo - (GDayInMonth[I + 1] + CheckLeap(I, Leap));
    I := I + 1;
  end;
  GMonth := I + 1;
  GDay := GDayNo + 1;
  Result := EncodeDate(GYear, GMonth, GDay);
end;

{ *********************************************************** }

{
  function TRyDate.JalaliWeeksInYear(JalaliYear, JalaliMonth,
  JalaliDay: Integer): Byte;
  begin

  end;

  function TRyDate.JalaliWeeksInYear(JalaliDate: string): Byte;
  var
  Y, M, D: Integer;
  begin
  Y := StrToIntDef(LeftStr(JalaliDate, 4), 0);
  M := StrToIntDef(MidStr(JalaliDate, 6, 2), 0);
  D := StrToIntDef(RightStr(JalaliDate, 2), 0);

  end;
}

end.
