unit FDTanque;

interface

uses
  uITanque, Data.DB, uTanque;

type

  TFDTanque = class(TInterfacedObject, ITanque)
    constructor Create;
    destructor Destroy;override;
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
  uDmTanque, System.SysUtils, Vcl.Forms;

{ TFDTanque }

constructor TFDTanque.Create;
begin
  if DmTanque = nil then
    Application.CreateForm(TDmTanque, DmTanque);

  DmTanque.QryTanque.Active := True;
end;

destructor TFDTanque.Destroy;
begin
  inherited;

end;

function TFDTanque.Editar(Id: Integer): TDataSource;
begin
  try
    ListaTanquePorId(id);
    Result := DmTanque.DsTanque;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDTanque.Excluir(Id: Integer);
begin
  try
    ListaTanquePorId(id);
    if DmTanque.QryTanque.RecordCount > 0 then
      DmTanque.QryTanque.Delete;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDTanque.ListaTanquePorId(Id: Integer);
begin
  try
    DmTanque.QryTanque.SQL.Text := 'SELECT * FROM TANQUE WHERE ID = :id ORDER BY ID';
    DmTanque.QryTanque.ParamByName('id').AsString := IntToStr(Id);
    DmTanque.QryTanque.Open;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDTanque.ListaTanques(Nome: String = ''): TDataSource;
begin
  try
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
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDTanque.RetornaNomeTanque(Id: Integer): String;
begin
  try
    ListaTanquePorId(id);
    Result := DmTanque.QryTanqueNOME.AsString;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TFDTanque.RetornaTanquePorId(Id: Integer): TTanque;
var
  Tanque: TTanque;
begin
  try
    ListaTanquePorId(Id);
    if DmTanque.QryTanque.RecordCount > 0 then
      begin
        Tanque := TTanque.Create;
        Tanque.Id := DmTanque.QryTanque.FieldByName('id').AsInteger;
        Tanque.Nome := DmTanque.QryTanque.FieldByName('nome').AsString;
        Tanque.TipoCombustivel := TTpCombustivel(DmTanque.QryTanque.FieldByName('TIPO_COMBUSTIVEL').AsInteger);
        Result := Tanque;
      end;
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TFDTanque.Salvar(Tanque: TTanque; Id: Integer);
var
  tpCombustivel: Integer;
begin
  try
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
  Except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
