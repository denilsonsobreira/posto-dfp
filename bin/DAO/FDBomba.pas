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
  end;


implementation

uses
  uDmBomba, System.SysUtils, Vcl.Forms;

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
  ListaBombaPorId(id);
  Result := DmBomba.DsBomba;
end;

procedure TFDBomba.Excluir(Id: Integer);
begin
  ListaBombaPorId(id);
  if DmBomba.QryBomba.RecordCount > 0 then
    DmBomba.QryBomba.Delete;
end;

procedure TFDBomba.ListaBombaPorId(Id: Integer);
begin
  DmBomba.QryBomba.SQL.Text := 'SELECT B.ID, B.Nome, b.tanque_id, T.Nome as NomeTanque FROM BOMBA B ' +
                               ' LEFT JOIN TANQUE T ON B.TANQUE_ID = T.Id ' +
                               ' WHERE B.id = :id ORDER BY ID';
  DmBomba.QryBomba.ParamByName('id').AsString := IntToStr(Id);
  DmBomba.QryBomba.Open;
end;

function TFDBomba.ListaBombas(Nome: String): TDataSource;
begin
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
end;

procedure TFDBomba.Salvar(Bomba: TBomba; Id: Integer);
begin
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
end;

end.
