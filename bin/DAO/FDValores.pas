unit FDValores;

interface

uses
  uIValores, uValores, uDmValores, Data.DB;

type
  TFDValores = class(TInterfacedObject, IValores)
    constructor Create;
    destructor Destroy;override;
    procedure Salvar(Valores: TValores);
    function ListaValores(): TDataSource;
    function ValorImposto:Currency;
  end;

implementation

uses
  Vcl.Forms, System.SysUtils;

{ TFDValores }

constructor TFDValores.Create;
begin
  if DmValores = nil then
    Application.CreateForm(TDmValores, DmValores);
end;

destructor TFDValores.Destroy;
begin
  inherited;
end;

function TFDValores.ListaValores: TDataSource;
begin
  try
    DmValores.QryValores.SQL.Text := 'SELECT * FROM VALORES WHERE ID = (SELECT MAX(ID) FROM VALORES) ORDER BY ID;';
    DmValores.QryValores.Open;
    Result := DmValores.DsValores;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDValores.Salvar(Valores: TValores);
begin
  try
    DmValores.QryValores.SQL.Text := 'SELECT * FROM VALORES ORDER BY ID;';
    DmValores.QryValores.Open;

    if DmValores.QryValores.RecordCount = 0 then
      DmValores.QryValores.Append
    else if DmValores.QryValores.RecordCount = 1 then
      DmValores.QryValores.Edit;

    DmValores.QryValoresVALOR_LITRO_GASOLINA.AsCurrency := Valores.ValorLitroGasolina;
    DmValores.QryValoresVALOR_LITRO_OLEO_DIESEL.AsCurrency := Valores.ValorLitroOleoDiesel;
    DmValores.QryValoresVALOR_IMPOSTO.AsCurrency := Valores.ValorImposto;

    DmValores.QryValores.Post;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDValores.ValorImposto: Currency;
begin
  try
    DmValores.QryValores.SQL.Text := 'SELECT * FROM VALORES WHERE ID = (SELECT MAX(ID) FROM VALORES) ORDER BY ID;';
    DmValores.QryValores.Open;
    Result := DmValores.QryValoresVALOR_IMPOSTO.AsCurrency;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
