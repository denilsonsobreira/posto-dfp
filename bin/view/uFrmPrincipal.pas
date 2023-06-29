unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.ImgList, Vcl.Buttons;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

end.
