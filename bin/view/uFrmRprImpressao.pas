unit uFrmRprImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDmConexao,
  Datasnap.DBClient;

type
  TFrmRprImpressao = class(TForm)
    RLReport: TRLReport;
    RlBandTitle: TRLBand;
    RLDrawTitle: TRLDraw;
    RlLblPosto: TRLLabel;
    RlLblTitleData: TRLLabel;
    RLLabel1: TRLLabel;
    RLBandHeader: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RlLblValor: TRLLabel;
    RlLblTanque: TRLLabel;
    RlLblBomba: TRLLabel;
    RlLblData: TRLLabel;
    RLBandDetail: TRLBand;
    RLDBNomeTanque: TRLDBText;
    QryAbastecimento: TFDQuery;
    DsAbastecimento: TDataSource;
    QryAbastecimentoDATAABASTECIMENTO: TDateField;
    QryAbastecimentoNOMEBOMBA: TStringField;
    QryAbastecimentoNOMETANQUE: TStringField;
    QryAbastecimentoVALOR_TOTAL: TBCDField;
    RLDBNomeBomba: TRLDBText;
    RLDBDataAbastecimento: TRLDBText;
    RLDBValor_Total: TRLDBText;
    RLBandFooter: TRLBand;
    RLDraw1: TRLDraw;
    RlLblValor_Total: TRLLabel;
    RlLblTotal: TRLLabel;
    RlLblInfoData: TRLLabel;
    procedure RLBandDetailBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandFooterBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ValorTotal: Currency;
  public
    { Public declarations }
  end;

var
  FrmRprImpressao: TFrmRprImpressao;

implementation


{$R *.dfm}

procedure TFrmRprImpressao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmRprImpressao.FormDestroy(Sender: TObject);
begin
  FrmRprImpressao := nil
end;

procedure TFrmRprImpressao.RLBandDetailBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  ValorTotal := ValorTotal + QryAbastecimento.FieldByName('Valor_Total').AsCurrency;
end;

procedure TFrmRprImpressao.RLBandFooterBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RlLblValor_Total.Caption := 'R$ ' + FormatFloat('#,##0.00',ValorTotal);
  ValorTotal := 0;
end;

end.
