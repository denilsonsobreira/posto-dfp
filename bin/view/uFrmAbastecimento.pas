unit uFrmAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmAbastecimento = class(TForm)
    PnlPagamento: TPanel;
    PnlBomba: TPanel;
    LblG: TLabel;
    LblGasolina: TLabel;
    LblDiesel: TLabel;
    LblD: TLabel;
    EdtValorGasolina: TEdit;
    EdtValorOleoDiesel: TEdit;
    LblTipoValorGasolina: TLabel;
    LblTipoValorDiesel: TLabel;
    ComboBox1: TComboBox;
    LblFormaAbastecimento: TLabel;
    LblLitros: TLabel;
    LblValor: TLabel;
    Total: TLabel;
    EdtLitros: TEdit;
    EdtValor: TEdit;
    EdtTotal: TEdit;
    BitBtn1: TBitBtn;
    GridPesquisaBomba: TDBGrid;
    PnlCamposBomba: TPanel;
    LblBomba: TLabel;
    EdtBomba: TEdit;
    LblTpCombustivel: TLabel;
    EdtTpCombuistivel: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbastecimento: TFrmAbastecimento;

implementation

{$R *.dfm}

end.
