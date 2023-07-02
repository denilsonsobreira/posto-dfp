unit FDAbastecimento;

interface

uses
  uIAbastecimento, FireDAC.Comp.Client, Data.DB;

type

  TFDAbastecimento = class(TInterfacedObject, IAbastecimento)
    constructor Create;
    destructor Destroy;override;
    function ListaBombasETipos(NomeBomba: String = ''): TDataSource;
  end;

implementation

uses
  uDmAbastecimento, Vcl.Forms, System.SysUtils;

{ TFDAbastecimento }

constructor TFDAbastecimento.Create;
begin
  if DmAbastecimento = nil then
    Application.CreateForm(TDmAbastecimento, DmAbastecimento);
end;

destructor TFDAbastecimento.Destroy;
begin
  inherited;

end;

function TFDAbastecimento.ListaBombasETipos(NomeBomba: String): TDataSource;
begin
  DmAbastecimento.QryBombasTipos.SQL.Text := ' SELECT B.NOME, T.TIPO_COMBUSTIVEL FROM BOMBA B ' +
                                             ' LEFT JOIN tanque T ON B.TANQUE_ID = T.ID ';
  DmAbastecimento.QryBombasTipos.Open;
  if DmAbastecimento.QryBombasTipos.RecordCount > 0 then
    begin
      if NomeBomba <> '' then
        begin
          DmAbastecimento.QryBombasTipos.SQL.Text := ' SELECT B.NOME, T.TIPO_COMBUSTIVEL FROM BOMBA B ' +
                                                     ' LEFT JOIN tanque T ON B.TANQUE_ID = T.ID ' +
                                                     ' WHERE B.NOME LIKE :nome ORDER BY B.NOME ';
          DmAbastecimento.QryBombasTipos.ParamByName('nome').AsString := '%' + NomeBomba + '%';
          DmAbastecimento.QryBombasTipos.Open;
        end;
    end;
  Result := DmAbastecimento.DsBombasTipos;
end;

end.
