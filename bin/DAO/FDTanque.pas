unit FDTanque;

interface

uses
  uITanque, Data.DB, uTanque;

type

  TFDTanque = class(TInterfacedObject, ITanque)
    procedure Salvar(Tanque: TTanque; Id: Integer = 0);
    function ListaTanques(Nome: String = ''): TDataSource;
    procedure ListaTanquePorId(Id: Integer);
    function Editar(Id: Integer): TDataSource;
    procedure Excluir(Id: Integer);
    function RetornaTanquePorId(Id: Integer): TTanque;
    function RetornaNomeTanque(Id: Integer): String;
  end;

implementation

uses
  uDmTanque, System.SysUtils;

{ TFDTanque }

function TFDTanque.Editar(Id: Integer): TDataSource;
begin
  ListaTanquePorId(id);
  Result := DmTanque.DsTanque;
end;

procedure TFDTanque.Excluir(Id: Integer);
begin
  ListaTanquePorId(id);
  if DmTanque.QryTanque.RecordCount > 0 then
    DmTanque.QryTanque.Delete;
end;

procedure TFDTanque.ListaTanquePorId(Id: Integer);
begin
  DmTanque.QryTanque.SQL.Text := 'SELECT * FROM TANQUE WHERE ID = :id ORDER BY ID';
  DmTanque.QryTanque.ParamByName('id').AsString := IntToStr(Id);
  DmTanque.QryTanque.Open;
end;

function TFDTanque.ListaTanques(Nome: String = ''): TDataSource;
begin
  DmTanque.QryTanque.Filtered := False;
  DmTanque.QryTanque.Filter := '';
  DmTanque.QryTanque.Filtered := True;
  DmTanque.QryTanque.SQL.Text := 'SELECT * FROM TANQUE ORDER BY ID';
  DmTanque.QryTanque.Open;
  if DmTanque.QryTanque.RecordCount > 0 then
    begin
      if Nome <> '' then
        begin
          DmTanque.QryTanque.SQL.Text := 'SELECT * FROM TANQUE WHERE NOME LIKE :nome ORDER BY ID';
          DmTanque.QryTanque.ParamByName('nome').AsString := '%' + Nome + '%';
          DmTanque.QryTanque.Open;
        end;
    end;
  Result := DmTanque.DsTanque;
end;

function TFDTanque.RetornaNomeTanque(Id: Integer): String;
begin
  ListaTanquePorId(id);
  Result := DmTanque.QryTanqueNOME.AsString;
end;

function TFDTanque.RetornaTanquePorId(Id: Integer): TTanque;
var
  Tanque: TTanque;
begin
  ListaTanquePorId(Id);
  if DmTanque.QryTanque.RecordCount > 0 then
    begin
      Tanque := TTanque.Create;
      Tanque.Id := DmTanque.QryTanque.FieldByName('id').AsInteger;
      Tanque.Nome := DmTanque.QryTanque.FieldByName('nome').AsString;
      Tanque.TipoCombustivel := TTpCombustivel(DmTanque.QryTanque.FieldByName('TIPO_COMBUSTIVEL').AsInteger);
      Result := Tanque;
    end;
end;

procedure TFDTanque.Salvar(Tanque: TTanque; Id: Integer);
var
  tpCombustivel: Integer;
begin
  case Tanque.TipoCombustivel of
    Gasolina: tpCombustivel := 0;
    OleoDisel: tpCombustivel := 1;
    else tpCombustivel := 99;
  end;

  if id = 0 then DmTanque.QryTanque.Append
  else
    begin
      ListaTanquePorId(id);
      DmTanque.QryTanque.Edit;
    end;

  DmTanque.QryTanqueNOME.AsString := Tanque.Nome;
  DmTanque.QryTanqueTIPO_COMBUSTIVEL.AsInteger := tpCombustivel;
  DmTanque.QryTanque.Post;
end;

end.
