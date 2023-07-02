unit uFrmAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, CustomAttributesUtils;

type
  TFrmAbastecimento = class(TForm)
    [Bind('VALOR_LITRO_GASOLINA')]
    EdtValorGasolina: TEdit;

    [Bind('VALOR_LITRO_OLEO_DIESEL')]
    EdtValorOleoDiesel: TEdit;

    [Bind('NOME')]
    EdtBomba: TEdit;

    [Bind('TANQUE_ID')]
    EdtTpCombuistivel: TEdit;

    PnlPagamento: TPanel;
    PnlBomba: TPanel;
    LblG: TLabel;
    LblGasolina: TLabel;
    LblDiesel: TLabel;
    LblD: TLabel;
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
    LblTpCombustivel: TLabel;
    PnlPesquisa: TPanel;
    BtnPesquisar: TBitBtn;
    EdtPesquisar: TEdit;
    LblPesquisar: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure GridPesquisaBombaCellClick(Column: TColumn);
    procedure GridPesquisaBombaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure CarregarConfiguracoes;
    procedure CarregarValores;
    procedure CarregarBombas;
    procedure PreencherCamposBomba;
  public
    { Public declarations }
  end;

var
  FrmAbastecimento: TFrmAbastecimento;

implementation

uses
  AbastecimentoController;

{$R *.dfm}

{ TFrmAbastecimento }

procedure TFrmAbastecimento.BtnPesquisarClick(Sender: TObject);
begin
  CarregarBombas;
end;

procedure TFrmAbastecimento.CarregarBombas;
var
  AbastecimentoController: TAbastecimentoController;
begin
  AbastecimentoController := TAbastecimentoController.Create;
  try
    AbastecimentoController.CarregaBombas(Self, GridPesquisaBomba, EdtPesquisar.Text);
    PreencherCamposBomba
  finally
    AbastecimentoController.Free;
  end;
end;

procedure TFrmAbastecimento.CarregarConfiguracoes;
begin
  CarregarValores;
end;

procedure TFrmAbastecimento.CarregarValores;
var
  AbastecimentoController: TAbastecimentoController;
begin
  AbastecimentoController := TAbastecimentoController.Create;
  try
    AbastecimentoController.CarregaValores(Self);
  finally
    AbastecimentoController.Free;
  end;
end;

procedure TFrmAbastecimento.EdtPesquisarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then CarregarBombas;
end;

procedure TFrmAbastecimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAbastecimento.FormDestroy(Sender: TObject);
begin
  FrmAbastecimento := nil;
end;

procedure TFrmAbastecimento.FormShow(Sender: TObject);
begin
  CarregarConfiguracoes;
end;

procedure TFrmAbastecimento.GridPesquisaBombaCellClick(Column: TColumn);
begin
  if GridPesquisaBomba.DataSource <> nil then
    PreencherCamposBomba;
end;

procedure TFrmAbastecimento.GridPesquisaBombaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  PreencherCamposBomba;
end;

procedure TFrmAbastecimento.PreencherCamposBomba;
begin
  EdtBomba.Text := GridPesquisaBomba.DataSource.DataSet.FieldByName('nome').AsString;
  case GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger of
    0: EdtTpCombuistivel.Text := 'Gasolina';
    1: EdtTpCombuistivel.Text := 'Óleo Diesel';
  end;
end;

end.
