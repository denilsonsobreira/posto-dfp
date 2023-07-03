unit uFrmImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, uFrmRprImpressao, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmImpressao = class(TForm)
    DTDataInicial: TDateTimePicker;
    DTDataFinal: TDateTimePicker;
    Panel1: TPanel;
    Panel2: TPanel;
    BtnImprimir: TBitBtn;
    LblDataInicial: TLabel;
    LblDataFinal: TLabel;
    procedure BtnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Imprimir;
    function ValidaData:Boolean;
  public
    { Public declarations }
  end;

var
  FrmImpressao: TFrmImpressao;

implementation

{$R *.dfm}

procedure TFrmImpressao.BtnImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TFrmImpressao.Imprimir;
begin
  if not(ValidaData) then exit;


  if FrmRprImpressao = nil then
    Application.CreateForm(TFrmRprImpressao, FrmRprImpressao);


  FrmRprImpressao.QryAbastecimento.SQL.Text := 'select A.data as DataAbastecimento, B.NOME as NomeBomba, T.NOME as NomeTanque, A.VALOR_TOTAL ' +
                               ' from abastecimento A ' +
                               ' INNER JOIN Bomba B ON A.bomba_id = B.Id ' +
                               ' INNER JOIN TANQUE T ON B.TANQUE_ID = T.ID ' +
                               ' WHERE Data >= '''+FormatDateTime('yyyy-mm-dd',DTDataInicial.Date)+'''' +
                               ' AND Data <= '''+FormatDateTime('yyyy-mm-dd',DTDataFinal.Date)+'''' +
                               ' ORDER BY A.DATA';

  FrmRprImpressao.QryAbastecimento.Open;
  if FrmRprImpressao.QryAbastecimento.RecordCount > 0 then
    begin
      FrmRprImpressao.RlLblInfoData.Caption := 'Exibindo relatório entre ' + FormatDateTime('dd/mm/yyyy',DTDataInicial.Date) + ' e ' + FormatDateTime('dd/mm/yyyy',DTDataFinal.Date);
      FrmRprImpressao.RLReport.Preview();
    end
  else
    Application.MessageBox('Não foram encontrados abastecimentos no período informado.', 'PostoDFP', MB_ICONINFORMATION);

end;

function TFrmImpressao.ValidaData: Boolean;
begin
  Result := false;

  if (DTDataInicial.Date > DTDataFinal.Date) then
    begin
      Application.MessageBox('Data Inicial não pode ser maior que a Data Final.', 'Atenção', MB_ICONWARNING);
      exit;
    end;

  Result := true;
end;

end.
