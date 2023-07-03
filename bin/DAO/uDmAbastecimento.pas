unit uDmAbastecimento;

interface

uses
  System.SysUtils, System.Classes, uDmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmAbastecimento = class(TDataModule)
    QryAbastecimento: TFDQuery;
    DsAbastecimento: TDataSource;
    QryAbastecimentoID: TIntegerField;
    QryAbastecimentoLITROS: TBCDField;
    QryAbastecimentoVALOR_TOTAL: TBCDField;
    QryAbastecimentoIMPOSTO: TBCDField;
    QryAbastecimentoDATA: TDateField;
    QryAbastecimentoBOMBA_ID: TIntegerField;
    QryBombasTipos: TFDQuery;
    DsBombasTipos: TDataSource;
    QryBombasTiposNOME: TStringField;
    QryBombasTiposTIPO_COMBUSTIVEL: TIntegerField;
    QryBombasTiposID: TIntegerField;
    procedure QryBombasTiposTIPO_COMBUSTIVELGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmAbastecimento: TDmAbastecimento;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmAbastecimento.QryBombasTiposTIPO_COMBUSTIVELGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if DisplayText then
    begin
      case QryBombasTiposTIPO_COMBUSTIVEL.AsInteger of
        0: Text := 'Gasolina';
        1: Text := 'Óleo Diesel';
      end;
    end
  else
    Text := QryBombasTiposTIPO_COMBUSTIVEL.AsString;
end;

end.
