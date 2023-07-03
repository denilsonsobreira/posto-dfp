unit FDAbastecimento;

interface

uses
  uIAbastecimento, FireDAC.Comp.Client, Data.DB, uAbastecimento;

type

  TFDAbastecimento = class(TInterfacedObject, IAbastecimento)
    constructor Create;
    destructor Destroy;override;
    function ListaBombasETipos(NomeBomba: String = ''): TDataSource;
    procedure Salvar(Abastecimento: TAbastecimento);
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
  try
    DmAbastecimento.QryBombasTipos.SQL.Text := ' SELECT B.ID, B.NOME, T.TIPO_COMBUSTIVEL FROM BOMBA B ' +
                                               ' LEFT JOIN tanque T ON B.TANQUE_ID = T.ID ';
    DmAbastecimento.QryBombasTipos.Open;
    if DmAbastecimento.QryBombasTipos.RecordCount > 0 then
      begin
        if NomeBomba <> '' then
          begin
            DmAbastecimento.QryBombasTipos.SQL.Text := ' SELECT B.ID, B.NOME, T.TIPO_COMBUSTIVEL FROM BOMBA B ' +
                                                       ' LEFT JOIN tanque T ON B.TANQUE_ID = T.ID ' +
                                                       ' WHERE B.NOME LIKE :nome ORDER BY B.NOME ';
            DmAbastecimento.QryBombasTipos.ParamByName('nome').AsString := '%' + NomeBomba + '%';
            DmAbastecimento.QryBombasTipos.Open;
          end;
      end;
    Result := DmAbastecimento.DsBombasTipos;

  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDAbastecimento.Salvar(Abastecimento: TAbastecimento);
begin
  try
    try
      DmAbastecimento.QryAbastecimento.Append;

      DmAbastecimento.QryAbastecimentoLITROS.AsCurrency := Abastecimento.Litros;
      DmAbastecimento.QryAbastecimentoVALOR_TOTAL.AsCurrency := Abastecimento.ValorTotal;
      DmAbastecimento.QryAbastecimentoIMPOSTO.AsCurrency := Abastecimento.Imposto;
      DmAbastecimento.QryAbastecimentoDATA.AsDateTime := Date();
      DmAbastecimento.QryAbastecimentoBOMBA_ID.AsInteger := Abastecimento.Bomba.Id;

      DmAbastecimento.QryAbastecimento.Post;
    finally
      Abastecimento.Bomba.Tanque.Free;
      Abastecimento.Bomba.Free;
      Abastecimento.Free;
    end;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
