unit uFrmBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBase, Vcl.ImgList, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Actions,
  Vcl.ActnList, Vcl.Buttons, CustomAttributesUtils;

type
  TFrmBomba = class(TFrmBase)

    [Bind('ID')]
    EdtCodigo: TEdit;

    [Bind('NOME')]
    EdtNome: TEdit;

    [Bind('TANQUE_ID')]
    EdtCodTanque: TEdit;

    EdtNomeTanque: TEdit;
    LblCod: TLabel;
    LblNome: TLabel;
    Label1: TLabel;
    BtnPesquisarTanque: TBitBtn;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure BtnPesquisarTanqueClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtCodTanqueChange(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pesquisar;
    procedure Novo;
    procedure Salvar;
    procedure Editar;
    procedure Excluir;
  end;

var
  FrmBomba: TFrmBomba;

implementation

uses
  BombaController, uFrmConsulta, uBomba, uTanque;

{$R *.dfm}

procedure TFrmBomba.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TFrmBomba.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Editar;
end;

procedure TFrmBomba.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  Excluir;
end;

procedure TFrmBomba.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Novo;
end;

procedure TFrmBomba.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TFrmBomba.BtnPesquisarTanqueClick(Sender: TObject);
var
  BombaController: TBombaController;
  Tanque: TTanque;
begin
  inherited;

  Application.CreateForm(TFrmConsulta, FrmConsulta);

  BombaController := TBombaController.Create;
  Tanque := TTanque.Create;
  try
    FrmConsulta.SetConfig(BombaController.PesquisaTanques, Tanque);
    if FrmConsulta.ShowModal = mrYes then
      begin
        EdtCodTanque.Text := FrmConsulta.EdtCodRetorno.Text;
        EdtNomeTanque.Text := FrmConsulta.EdtNomeRetorno.Text;
      end;
  finally
    Tanque.Free;
    BombaController.Free;
    FrmConsulta.Free;
  end;
end;

procedure TFrmBomba.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Salvar;
end;

procedure TFrmBomba.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  if DbGridPesquisa.DataSource = nil then exit;
  PgPrincipal.ActivePage := TsCadastrar;
  Editar;
end;

procedure TFrmBomba.Editar;
var
  BombaController: TBombaController;
begin
  BombaController := TBombaController.Create;
  try
    Novo;
    BombaController.Editar(DbGridPesquisa.DataSource.DataSet.FieldByName('id').AsInteger, Self);
    EdtNome.SelStart := Length(EdtNome.Text);
  finally
    BombaController.Free;
  end;
end;

procedure TFrmBomba.EdtCodTanqueChange(Sender: TObject);
var
  BombaController: TBombaController;
begin
  inherited;
  if (EdtCodTanque.Text <> '') and (EdtNomeTanque.Text = '') then
    begin
      try
        BombaController := TBombaController.Create;
        EdtNomeTanque.Text := BombaController.RetornaNomeTanque(StrToInt(EdtCodTanque.Text));
      finally
        BombaController.Free;
      end;
    end;
end;

procedure TFrmBomba.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then Pesquisar;
end;

procedure TFrmBomba.Excluir;
var
  BombaController: TBombaController;
begin
  if Application.MessageBox('Tem certeza que deseja excluir esse registro?', 'Atenção', MB_YESNO + MB_ICONQUESTION) = 6 then
    begin
      BombaController := TBombaController.Create;
      try
        BombaController.Excluir(DbGridPesquisa.DataSource.DataSet.FieldByName('id').AsInteger);
        Pesquisar;
      finally
        BombaController.Free;
      end;
    end;
end;

procedure TFrmBomba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmBomba.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmBomba := nil;
end;

procedure TFrmBomba.Novo;
begin
  EdtNome.Text := '';
  EdtCodigo.Text := '';
  EdtCodTanque.Text := '';
  EdtNomeTanque.Text := '';
  EdtNome.SetFocus;
end;

procedure TFrmBomba.Pesquisar;
var
  BombaController: TBombaController;
begin
  BombaController := TBombaController.Create;
  try
    BombaController.ListaBombas(DbGridPesquisa, EdtPesquisar.Text);
  finally
    BombaController.Free;
  end;
end;

procedure TFrmBomba.Salvar;
var
  Bomba: TBomba;
  BombaController: TBombaController;
begin
  BombaController := TBombaController.Create;
  Bomba := TBomba.Create;
  try
    Bomba.Nome := EdtNome.Text;
    if EdtCodTanque.Text <> '' then
      Bomba.Tanque := BombaController.RetornaTanque(StrToInt(EdtCodTanque.Text));
    if EdtCodigo.Text = '' then
      BombaController.Salvar(Bomba, 0)
    else BombaController.Salvar(Bomba, StrToInt(EdtCodigo.Text));

    Application.MessageBox('Registro Salvo com sucesso', 'Sucesso', MB_OK+MB_ICONINFORMATION);
    PgPrincipal.ActivePage := TsPesquisar;
    Pesquisar;
  finally
    BombaController.Free;
  end;
end;

end.
