unit CustomAttributesUtils;

interface

type
  ColumnInfo = class(TCustomAttribute)
    private
      FName: String;
      FDBName: String;
      FWidth: Integer;
      procedure SetName(const Value: String);
    procedure SetDBName(const Value: String);
    procedure SetWidth(const Value: Integer);
    public
      constructor create(aDBName, aName: String; aWidth: Integer);

      property DBName: String read FDBName write SetDBName;
      property Name: String read FName write SetName;
      property Width: Integer read FWidth write SetWidth;
  end;

  Bind = class(TCustomAttribute)
    private
    FField: String;
    procedure SetField(const Value: String);
    public
      constructor Create(aField: String);
      property Field: String read FField write SetField;
  end;

  NotNull = class(TCustomAttribute)
    private
    FMensagem: String;
    procedure SetMensagem(const Value: String);
    public
      constructor create(aMsg: String);
      property Mensagem : String read FMensagem write SetMensagem;
  end;

  MinLength = class(TCustomAttribute)
    private
    FLength: Integer;
    FMsg: String;
    procedure SetLength(const Value: Integer);
    procedure SetMsg(const Value: String);
    public
      constructor Create(aLength: Integer; aMsg: String);
      property Length: Integer read FLength write SetLength;
      property Msg : String read FMsg write SetMsg;
  end;

implementation

{ ColumnInfo }

constructor ColumnInfo.create(aDBName, aName: String; aWidth: Integer);
begin
  FDBName := aDBName;
  FName := aName;
  FWidth := aWidth;
end;

procedure ColumnInfo.SetDBName(const Value: String);
begin
  FDBName := Value;
end;

procedure ColumnInfo.SetName(const Value: String);
begin
  FName := Value;
end;

procedure ColumnInfo.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ Bind }

constructor Bind.Create(aField: String);
begin
  FField := aField;
end;

procedure Bind.SetField(const Value: String);
begin
  FField := Value;
end;

{ NotNull }

constructor NotNull.create(aMsg: String);
begin
  FMensagem := aMsg;
end;

procedure NotNull.SetMensagem(const Value: String);
begin
  FMensagem := Value;
end;

{ MinLength }

constructor MinLength.Create(aLength: Integer; aMsg: String);
begin
  FLength := aLength;
  FMsg := aMsg;
end;

procedure MinLength.SetLength(const Value: Integer);
begin
  FLength := Value;
end;

procedure MinLength.SetMsg(const Value: String);
begin
  FMsg := Value;
end;

end.
