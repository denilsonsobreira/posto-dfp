unit uFrmTanque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBase, Vcl.ImgList, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, uTanque,
  CustomAttributesUtils, System.Actions, Vcl.ActnList;

type
  TFrmTanque = class(TFrmBase)

    [Bind('ID')]
    EdtCodigo: TEdit;

    [Bind('NOME')]
    EdtNome: TEdit;

    [Bind('TIPO_COMBUSTIVEL')]
    CbTpCombustivel: TComboBox;

    LblCod: TLabel;
    LblNome: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEditarClick(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function TxtParaTpCombustivel(aValue: String): TTpCombustivel;
  public
    { Public declarations }
    procedure Configuracoes;
    procedure Salvar;
    procedure Novo;
    procedure Pesquisar;
    procedure Editar;
    procedure Excluir;
  end;

var
  FrmTanque: TFrmTanque;

implementation

{$R *.dfm}

uses TanqueController;

procedure TFrmTanque.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TFrmTanque.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFrmTanque.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  Excluir;
end;

procedure TFrmTanque.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Novo;
end;

procedure TFrmTanque.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TFrmTanque.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Salvar;
end;

procedure TFrmTanque.Configuracoes;
var
  TpCombustivel: TTpCombustivel;
begin
  CbTpCombustivel.Clear;
  for TpCombustivel := Low(TpCombustivel) to High(TpCombustivel) do
    CbTpCombustivel.Items.Add(TTanque.TpCombustivelString[TpCombustivel]);
end;

procedure TFrmTanque.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  if DbGridPesquisa.DataSource = nil then exit;
  PgPrincipal.ActivePage := TsCadastrar;
  Editar;
end;

procedure TFrmTanque.Editar;
var
  TanqueController: TTanqueController;
begin
  TanqueController := TTanqueController.Create;
  try
    Novo;
    TanqueController.Editar(DbGridPesquisa.DataSource.DataSet.FieldByName('id').AsInteger, Self);
    EdtNome.SelStart := Length(EdtNome.Text);
  finally
    TanqueController.Free;
  end;
end;

procedure TFrmTanque.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then Pesquisar;
end;

procedure TFrmTanque.Excluir;
var
  TanqueController: TTanqueController;
begin
  if Application.MessageBox('Tem certeza que deseja excluir esse registro?', 'Atenção', MB_YESNO + MB_ICONQUESTION) = 6 then
    begin
      TanqueController := TTanqueController.Create;
      try
        TanqueController.Excluir(DbGridPesquisa.DataSource.DataSet.FieldByName('id').AsInteger);
        Pesquisar;
      finally
        TanqueController.Free;
      end;
    end;
end;

procedure TFrmTanque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmTanque.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmTanque := nil;
end;

procedure TFrmTanque.FormShow(Sender: TObject);
begin
  inherited;
  Configuracoes;
end;

procedure TFrmTanque.Novo;
begin
  EdtNome.Text := '';
  EdtCodigo.Text := '';
  CbTpCombustivel.ItemIndex := -1;
  EdtNome.SetFocus;
end;

procedure TFrmTanque.Pesquisar;
var
  TanqueController: TTanqueController;
begin
  TanqueController := TTanqueController.Create;
  try
    TanqueController.ListaTanques(DbGridPesquisa, EdtPesquisar.Text);
  finally
    TanqueController.Free;
  end;
end;

procedure TFrmTanque.Salvar;
var
  Tanque: TTanque;
  TanqueController: TTanqueController;
begin
  TanqueController := TTanqueController.Create;
  Tanque := TTanque.Create;
  try
    Tanque.Nome := EdtNome.Text;
    Tanque.TipoCombustivel := TxtParaTpCombustivel(CbTpCombustivel.Text);

    if EdtCodigo.Text = '' then
      TanqueController.Salvar(Tanque, 0)
    else TanqueController.Salvar(Tanque, StrToInt(EdtCodigo.Text));

    Application.MessageBox('Registro Salvo com sucesso', 'Sucesso', MB_OK+MB_ICONINFORMATION);
    PgPrincipal.ActivePage := TsPesquisar;
    Pesquisar;
  finally
    TanqueController.Free;
    Tanque.Free;
  end;
end;

function TFrmTanque.TxtParaTpCombustivel(aValue: String): TTpCombustivel;
begin
  if aValue = 'Gasolina' then
    Result := TTpCombustivel.Gasolina
  else if aValue = 'Óleo diesel' then
    Result := TTpCombustivel.OleoDisel;
end;

end.
