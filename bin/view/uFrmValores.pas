unit uFrmValores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  CustomAttributesUtils, System.Actions, Vcl.ActnList;

type
  TFrmValores = class(TForm)

    [Bind('VALOR_LITRO_GASOLINA')]
    EdtValorGasolina: TEdit;
    [Bind('VALOR_LITRO_OLEO_DIESEL')]
    EdtValorOleoDiesel: TEdit;
    [Bind('VALOR_IMPOSTO')]
    EdtValorImposto: TEdit;

    PnlBotao: TPanel;
    PnlCabecalho: TPanel;
    LblLitroGasolina: TLabel;
    LblLitroOleoDiesel: TLabel;
    LblValorImposto: TLabel;
    LblLitroTipo: TLabel;
    LblLitroOleoDieselTipo: TLabel;
    LblValorImpostoTipo: TLabel;
    BtnSalvar: TBitBtn;
    ActionList: TActionList;
    AcSalvar: TAction;
    procedure FormShow(Sender: TObject);
    procedure EdtValorGasolinaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSalvarClick(Sender: TObject);
    procedure EdtValorOleoDieselKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorImpostoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure ApenasNumerico(var key: char);
    procedure Configurar;
  public
    { Public declarations }
  end;

var
  FrmValores: TFrmValores;

implementation

uses
  ValoresController, uValores;

{$R *.dfm}

procedure TFrmValores.ApenasNumerico(var key: char);
begin
  if not(Key in ['0'..'9',Char(8),Char(44)]) then
    Key := #0;
end;

procedure TFrmValores.BtnSalvarClick(Sender: TObject);
var
  ValoresController: TValoresController;
  Valores: TValores;
begin
  ValoresController := TValoresController.create;
  Valores := TValores.Create;
  try
    Valores.ValorLitroGasolina := StrToCurr(EdtValorGasolina.Text);
    Valores.ValorLitroOleoDiesel := StrToCurr(EdtValorOleoDiesel.Text);
    Valores.ValorImposto := StrToCurr(EdtValorImposto.Text);
    ValoresController.Salvar(Valores);
    Application.MessageBox('Registro Salvo com sucesso', 'Sucesso', MB_OK+MB_ICONINFORMATION);
  finally
    ValoresController.Free;
    Valores.Free;
  end;
end;

procedure TFrmValores.Configurar;
var
  ValoresController: TValoresController;
begin
  ValoresController := TValoresController.create;
  try
    EdtValorGasolina.Text := FormatFloat('#,##0.00', 0);
    EdtValorOleoDiesel.Text := FormatFloat('#,##0.00', 0);
    EdtValorImposto.Text := FormatFloat('#,##0.00', 0);
    ValoresController.ListaValores(Self);
  finally
    ValoresController.Free;
  end;

end;

procedure TFrmValores.EdtValorGasolinaKeyPress(Sender: TObject; var Key: Char);
begin
  ApenasNumerico(key);
end;

procedure TFrmValores.EdtValorImpostoKeyPress(Sender: TObject; var Key: Char);
begin
  ApenasNumerico(key);
end;

procedure TFrmValores.EdtValorOleoDieselKeyPress(Sender: TObject;
  var Key: Char);
begin
  ApenasNumerico(key);
end;

procedure TFrmValores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmValores.FormDestroy(Sender: TObject);
begin
  FrmValores := nil;
end;

procedure TFrmValores.FormShow(Sender: TObject);
begin
  Configurar;
end;

end.
