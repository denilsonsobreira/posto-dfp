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
    procedure FormDestroy(Sender: TObject);
    procedure MItemBombasClick(Sender: TObject);
    procedure MItemTanquesClick(Sender: TObject);
    procedure btnValoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uFrmBomba, uFrmTanque, uFrmValores ;

{$R *.dfm}

procedure TFrmPrincipal.btnValoresClick(Sender: TObject);
begin
  if FrmValores = nil then
    Application.CreateForm(TFrmValores, FrmValores);

  FrmValores.ShowModal;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
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
