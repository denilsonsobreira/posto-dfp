unit FDBomba;

interface

uses
  uIBomba, uBomba, Data.DB;

type
  TFDBomba = class(TInterfacedObject, IBomba)
    constructor Create;
    destructor Destroy;override;
    procedure Salvar(Bomba: TBomba; Id: Integer = 0);
    function ListaBombas(Nome: String = ''): TDataSource;
    procedure ListaBombaPorId(Id: Integer);
    function Editar(Id: Integer): TDataSource;
    procedure Excluir(Id: Integer);
    function RetornaBombaPorId(Id: Integer):TBomba;
  end;


implementation

uses
  uDmBomba, System.SysUtils, Vcl.Forms, uTanque;

{ TFDBomba }

constructor TFDBomba.Create;
begin
  if DmBomba = nil then
    Application.CreateForm(TDmBomba, DmBomba);
end;

destructor TFDBomba.Destroy;
begin
  inherited;

end;

function TFDBomba.Editar(Id: Integer): TDataSource;
begin
  try
    ListaBombaPorId(id);
    Result := DmBomba.DsBomba;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDBomba.Excluir(Id: Integer);
begin
  try
    ListaBombaPorId(id);
    if DmBomba.QryBomba.RecordCount > 0 then
      DmBomba.QryBomba.Delete;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDBomba.ListaBombaPorId(Id: Integer);
begin
  try
    DmBomba.QryBomba.SQL.Text := 'SELECT B.ID, B.Nome, b.tanque_id, T.Nome as NomeTanque FROM BOMBA B ' +
                                 ' LEFT JOIN TANQUE T ON B.TANQUE_ID = T.Id ' +
                                 ' WHERE B.id = :id ORDER BY ID';
    DmBomba.QryBomba.ParamByName('id').AsString := IntToStr(Id);
    DmBomba.QryBomba.Open;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDBomba.ListaBombas(Nome: String): TDataSource;
begin
  try
    DmBomba.QryBomba.SQL.Text := 'SELECT * FROM BOMBA ORDER BY ID ';
    DmBomba.QryBomba.Open;
    if DmBomba.QryBomba.RecordCount > 0 then
      begin
        if Nome <> '' then
          begin
            DmBomba.QryBomba.SQL.Text := 'SELECT * FROM BOMBA WHERE NOME LIKE :nome ORDER BY ID ';
            DmBomba.QryBomba.ParamByName('nome').AsString := '%' + Nome + '%';
            DmBomba.QryBomba.Open;
          end;
      end;
    Result := DmBomba.DsBomba;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDBomba.RetornaBombaPorId(Id: Integer): TBomba;
var
  Bomba: TBomba;
begin
  try
    ListaBombaPorId(Id);
    if DmBomba.QryBomba.RecordCount > 0 then
      begin
          Bomba := TBomba.Create;
          Bomba.Id := DmBomba.QryBombaID.AsInteger;
          Bomba.Nome := DmBomba.QryBombaNOME.AsString;
          Bomba.Tanque := TTAnque.create;
          Bomba.Tanque.Id := DmBomba.QryBombaTANQUE_ID.AsInteger;
          Result := Bomba;
      end;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDBomba.Salvar(Bomba: TBomba; Id: Integer);
begin
  try
    if id = 0 then DmBomba.QryBomba.Append
    else
      begin
      ListaBombaPorId(id);
      DmBomba.QryBomba.Edit;
      end;
    DmBomba.QryBombaNOME.AsString := Bomba.Nome;
    DmBomba.QryBombaTANQUE_ID.AsInteger := Bomba.Tanque.Id;
    DmBomba.QryBomba.Post;
    Bomba.Tanque.Free;
    Bomba.Free;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
