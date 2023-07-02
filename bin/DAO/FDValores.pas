unit FDValores;

interface

uses
  uIValores, uValores, uDmValores, Data.DB;

type
  TFDValores = class(TInterfacedObject, IValores)
    procedure Salvar(Valores: TValores);
    function ListaValores(): TDataSource;
  end;

implementation

{ TFDValores }

function TFDValores.ListaValores: TDataSource;
begin
  DmValores.QryValores.SQL.Text := 'SELECT * FROM VALORES WHERE ID = (SELECT MAX(ID) FROM VALORES) ORDER BY ID;';
  DmValores.QryValores.Open;
  Result := DmValores.DsValores;
end;

procedure TFDValores.Salvar(Valores: TValores);
begin
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

end;

end.
