unit uFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, System.Actions, Vcl.ActnList;

type
  TFrmBase = class(TForm)
    PgPrincipal: TPageControl;
    TsPesquisar: TTabSheet;
    TsCadastrar: TTabSheet;
    PnlFooter: TPanel;
    PnlPesquisa: TPanel;
    PnlButtons: TPanel;
    BtnFechar: TButton;
    Images: TImageList;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnExcluir: TButton;
    EdtPesquisar: TEdit;
    LblPesquisar: TLabel;
    BtnPesquisar: TButton;
    DbGridPesquisa: TDBGrid;
    PnlButtonsCad: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    ActionList: TActionList;
    AcNovo: TAction;
    AcSalvar: TAction;
    AcCancelar: TAction;
    AcPesquisar: TAction;
    AcExcluir: TAction;
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Configuracoes;
    procedure Novo;
    procedure Editar;
    procedure Cancelar;
    procedure Excluir;
  public
    { Public declarations }
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

{ TFrmBase }

procedure TFrmBase.BtnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFrmBase.BtnEditarClick(Sender: TObject);
begin
  Editar;
end;

procedure TFrmBase.BtnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFrmBase.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmBase.BtnNovoClick(Sender: TObject);
begin
  Novo;
end;

procedure TFrmBase.BtnPesquisarClick(Sender: TObject);
begin
  //
end;

procedure TFrmBase.BtnSalvarClick(Sender: TObject);
begin
  //
end;

procedure TFrmBase.Cancelar;
begin
  PgPrincipal.ActivePage := TsPesquisar;
end;

procedure TFrmBase.Configuracoes;
begin
  TsPesquisar.TabVisible := false;
  TsCadastrar.TabVisible := false;
  PgPrincipal.ActivePage := TsPesquisar;
  DbGridPesquisa.DataSource := nil;
  EdtPesquisar.SetFocus;
end;

procedure TFrmBase.Editar;
begin
  if DbGridPesquisa.DataSource = nil then
    raise Exception.Create('Nenhum Registro para ser editado.');
  PgPrincipal.ActivePage := TsCadastrar;
end;

procedure TFrmBase.Excluir;
begin
  if DbGridPesquisa.DataSource = nil then
    raise Exception.Create('Nenhum Registro para ser excluído.');
end;

procedure TFrmBase.FormShow(Sender: TObject);
begin
  Configuracoes;
end;

procedure TFrmBase.Novo;
begin
  PgPrincipal.ActivePage := TsCadastrar;
end;

end.
