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
    CbTipoAbastecimento: TComboBox;
    LblFormaAbastecimento: TLabel;
    LblLitros: TLabel;
    LblValor: TLabel;
    Total: TLabel;
    EdtLitros: TEdit;
    EdtValor: TEdit;
    EdtTotal: TEdit;
    BtnAbastecer: TBitBtn;
    GridPesquisaBomba: TDBGrid;
    PnlCamposBomba: TPanel;
    LblBomba: TLabel;
    LblTpCombustivel: TLabel;
    PnlPesquisa: TPanel;
    BtnPesquisar: TBitBtn;
    EdtPesquisar: TEdit;
    LblPesquisar: TLabel;
    LblTipoValor: TLabel;
    LblLitro: TLabel;
    LblTipoTotal: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure GridPesquisaBombaCellClick(Column: TColumn);
    procedure GridPesquisaBombaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAbastecerClick(Sender: TObject);
    procedure CbTipoAbastecimentoChange(Sender: TObject);
    procedure EdtLitrosChange(Sender: TObject);
    procedure EdtLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorChange(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarConfiguracoes;
    procedure CarregarValores;
    procedure CarregarBombas;
    procedure PreencherCamposBomba;
    procedure Abastecer;
    procedure ApenasNumerico(var key: char);
    procedure CalculoPorLitro;
    procedure CalculoPorValor;
    function CalculaTotalPorLitro(QtdLitros, ValorCombustivel: Currency): Currency;
    function CalculaLitrosPorValor(Valor, ValorCombustivel: Currency): Currency;
    function StringToCurrency(Edit: TEdit): Currency;
  public
    { Public declarations }
  end;

var
  FrmAbastecimento: TFrmAbastecimento;

implementation

uses
  AbastecimentoController, uAbastecimento;

{$R *.dfm}

{ TFrmAbastecimento }

procedure TFrmAbastecimento.Abastecer;
var
  AbastecimentoController: TAbastecimentoController;
  Abastecimento: TAbastecimento;
begin
  if CbTipoAbastecimento.ItemIndex = -1 then
    begin
      Application.MessageBox('Selecione a forma de abastecimento', 'Atenção', MB_ICONWARNING);
      exit;
    end;

  if EdtBomba.Text = '' then
    begin
      Application.MessageBox('Selecione a bomba', 'Atenção', MB_ICONWARNING);
      exit;
    end;

  AbastecimentoController := TAbastecimentoController.Create;
  Abastecimento := TAbastecimento.Create;
  try
    Abastecimento.Litros := StringToCurrency(EdtLitros);
    Abastecimento.ValorTotal := StringToCurrency(EdtTotal);
    Abastecimento.Imposto := AbastecimentoController.CalculaImposto(StringToCurrency(EdtTotal));
    Abastecimento.Bomba := AbastecimentoController.RetornaBombaPorId(GridPesquisaBomba.DataSource.DataSet.FieldByName('ID').AsInteger);
    AbastecimentoController.Salvar(Abastecimento);
    Application.MessageBox('Abastecimento realizado com sucesso', 'Sucesso', MB_OK+MB_ICONINFORMATION);
  finally
    AbastecimentoController.Free;
  end;

end;

procedure TFrmAbastecimento.ApenasNumerico(var key: char);
begin
  if not(Key in ['0'..'9',Char(8),Char(44)]) then
    Key := #0;
end;

procedure TFrmAbastecimento.BtnAbastecerClick(Sender: TObject);
begin
  Abastecer;
end;

procedure TFrmAbastecimento.BtnPesquisarClick(Sender: TObject);
begin
  CarregarBombas;
end;

function TFrmAbastecimento.CalculaLitrosPorValor(Valor, ValorCombustivel: Currency): Currency;
begin
  Result := Valor / ValorCombustivel;
end;


function TFrmAbastecimento.CalculaTotalPorLitro(QtdLitros, ValorCombustivel: Currency): Currency;
begin
  Result := QtdLitros * ValorCombustivel;
end;

procedure TFrmAbastecimento.CalculoPorLitro;
var
  ValorCombustivel, ValorTotal: Currency;
begin
  if GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger = 0 then
    ValorCombustivel := StrToCurr(EdtValorGasolina.Text)
  else if GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger = 1 then
    ValorCombustivel := StrToCurr(EdtValorOleoDiesel.Text);
  if (CbTipoAbastecimento.ItemIndex = 0) and (EdtBomba.Text <> '') and (EdtLitros.Text <> '') then
    begin
      ValorTotal := CalculaTotalPorLitro(StrToCurr(EdtLitros.Text), ValorCombustivel);
      EdtTotal.Text := CurrToStr(ValorTotal);
      EdtValor.Text := CurrToStr(ValorTotal);
    end;
end;

procedure TFrmAbastecimento.CalculoPorValor;
var
  ValorCombustivel, ValorTotal, QtdLitros: Currency;
begin
  if GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger = 0 then
    ValorCombustivel := StrToCurr(EdtValorGasolina.Text)
  else if GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger = 1 then
    ValorCombustivel := StrToCurr(EdtValorOleoDiesel.Text);

  if (CbTipoAbastecimento.ItemIndex = 1) and (EdtBomba.Text <> '') and (EdtValor.Text <> '') then
    begin
      QtdLitros := CalculaLitrosPorValor(StrToCurr(EdtValor.Text), ValorCombustivel);
      EdtLitros.Text := CurrToStr(QtdLitros);
      EdtTotal.Text := EdtValor.Text;
    end;
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
    if (EdtValorGasolina.Text = '') or (EdtValorOleoDiesel.Text = '') then
      begin
        Application.MessageBox('Configure os valores antes de abastecer', 'Atenção', MB_ICONWARNING);
      end;

  finally
    AbastecimentoController.Free;
  end;
end;

procedure TFrmAbastecimento.CbTipoAbastecimentoChange(Sender: TObject);
begin
  if EdtBomba.Text = '' then
    begin
      Application.MessageBox('Selecione a bomba', 'Atenção', MB_ICONWARNING);
      CbTipoAbastecimento.ItemIndex := -1;
      exit;
    end;

  if CbTipoAbastecimento.ItemIndex = 0 then
    begin
      EdtLitros.Enabled := true;
      EdtValor.Enabled := false;
      EdtLitros.SetFocus;
      CalculoPorLitro;
    end
  else if CbTipoAbastecimento.ItemIndex = 1 then
    begin
      EdtLitros.Enabled := false;
      EdtValor.Enabled := true;
      EdtValor.SetFocus;
      CalculoPorValor;
    end;
end;

procedure TFrmAbastecimento.EdtLitrosChange(Sender: TObject);
begin
  if EdtLitros.Text = '' then
    begin
      EdtValor.Text := '';
      EdtTotal.Text := '';
    end
  else CalculoPorLitro;
end;

procedure TFrmAbastecimento.EdtLitrosKeyPress(Sender: TObject; var Key: Char);
begin
  ApenasNumerico(Key);
end;

procedure TFrmAbastecimento.EdtPesquisarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then CarregarBombas;
end;

procedure TFrmAbastecimento.EdtValorChange(Sender: TObject);
begin
  if EdtValor.Text = '' then
    begin
      EdtLitros.Text := '';
      EdtTotal.Text := '';
    end
  else CalculoPorValor;
end;

procedure TFrmAbastecimento.EdtValorKeyPress(Sender: TObject; var Key: Char);
begin
  ApenasNumerico(Key);
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
  if GridPesquisaBomba.DataSource <> nil then
    begin
      EdtBomba.Text := GridPesquisaBomba.DataSource.DataSet.FieldByName('nome').AsString;
      case GridPesquisaBomba.DataSource.DataSet.FieldByName('TIPO_COMBUSTIVEL').AsInteger of
        0: EdtTpCombuistivel.Text := 'Gasolina';
        1: EdtTpCombuistivel.Text := 'Óleo Diesel';
      end;
    end;

  if (CbTipoAbastecimento.ItemIndex = 0) and (EdtLitros.Text <> '') then
    CalculoPorLitro
  else if (CbTipoAbastecimento.ItemIndex = 1) and (EdtValor.Text <> '') then
    CalculoPorValor;
end;

function TFrmAbastecimento.StringToCurrency(Edit: TEdit): Currency;
begin
  try
    if Trim(Edit.Text) = '0' then
      begin
        Edit.SetFocus;
        abort;
      end;
    Result := StrToCurr(Edit.Text);
  Except
    Edit.SetFocus;
    raise Exception.Create('O Valor ' + Edit.Text + ' não é válido');
  end;
end;

end.
