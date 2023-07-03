unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.ImgList, Vcl.Buttons, Vcl.Forms;

type
  TFrmPrincipal = class(TForm)
    PnlPrincipal: TPanel;
    MainMenu: TMainMenu;
    MenuCadastros: TMenuItem;
    MItemTanques: TMenuItem;
    MItemBombas: TMenuItem;
    btnValores: TBitBtn;
    btnAbastecer: TBitBtn;
    btnRelatorio: TBitBtn;
    procedure MItemBombasClick(Sender: TObject);
    procedure MItemTanquesClick(Sender: TObject);
    procedure btnValoresClick(Sender: TObject);
    procedure btnAbastecerClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmBomba, uFrmTanque, uFrmValores, uFrmAbastecimento, uFrmImpressao ;

{$R *.dfm}

procedure TFrmPrincipal.btnAbastecerClick(Sender: TObject);
begin
  if FrmAbastecimento = nil then
    Application.CreateForm(TFrmAbastecimento, FrmAbastecimento);

  FrmAbastecimento.ShowModal;
end;

procedure TFrmPrincipal.btnRelatorioClick(Sender: TObject);
begin
  if FrmImpressao = nil then
    Application.CreateForm(TFrmImpressao, FrmImpressao);

  FrmImpressao.ShowModal;
end;

procedure TFrmPrincipal.btnValoresClick(Sender: TObject);
begin
  if FrmValores = nil then
    Application.CreateForm(TFrmValores, FrmValores);

  FrmValores.ShowModal;
end;

procedure TFrmPrincipal.MItemBombasClick(Sender: TObject);
begin
  if FrmBomba = nil then
    Application.CreateForm(TFrmBomba, FrmBomba);

  FrmBomba.ShowModal;
end;

procedure TFrmPrincipal.MItemTanquesClick(Sender: TObject);
begin
  if FrmTanque = nil then
    Application.CreateForm(TFrmTanque, FrmTanque);

  FrmTanque.ShowModal;
end;

end.
