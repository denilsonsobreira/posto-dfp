unit uFrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Data.DB, RttiUtils, Vcl.Buttons;

type
  TFrmConsulta = class(TForm)
    PnlPesquisa: TPanel;
    GridPesquisa: TDBGrid;
    EdtPesquisar: TEdit;
    EdtCodRetorno: TEdit;
    EdtNomeRetorno: TEdit;
    BtnPesquisar: TBitBtn;
    PnlSelecionar: TPanel;
    BtnSelecionar: TBitBtn;
    LblPesquisar: TLabel;
    CbTipoPesquisa: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure GridPesquisaDblClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDataSource: TDataSource;
    FObj: TObject;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetObj(const Value: TObject);
  public
    { Public declarations }
    property Obj : TObject read FObj write SetObj;
    property DataSource : TDataSource read FDataSource write SetDataSource;
    procedure SetConfig(aDataSource: TDataSource; aObject: TObject);
    procedure Selecionar;
    procedure Pesquisar;
  end;

var
  FrmConsulta: TFrmConsulta;

implementation

{$R *.dfm}

procedure TFrmConsulta.BtnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFrmConsulta.BtnSelecionarClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TFrmConsulta.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Pesquisar;
end;

procedure TFrmConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmConsulta.FormCreate(Sender: TObject);
begin
  GridPesquisa.DataSource := nil;
end;

procedure TFrmConsulta.FormDestroy(Sender: TObject);
begin
  FrmConsulta := nil;
end;

procedure TFrmConsulta.GridPesquisaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TFrmConsulta.Pesquisar;
begin
  if not (DataSource = nil) then
    begin
      DataSource.DataSet.Filtered := False;
      DataSource.DataSet.Filter := '';
      DataSource.DataSet.Filtered := True;
    end;
  TRttiUtils.DataSourceToGrid(FDataSource, GridPesquisa, FObj);
  if (not (GridPesquisa.DataSource = nil)) and (EdtPesquisar.Text <> '') then
    begin
    GridPesquisa.DataSource.DataSet.Filtered := False;
      if (CbTipoPesquisa.ItemIndex = -1) or (CbTipoPesquisa.ItemIndex = 0) then
        begin
          GridPesquisa.DataSource.DataSet.Filtered := False;
          GridPesquisa.DataSource.DataSet.Filter := 'Id LIKE ' + QuotedStr('%' + EdtPesquisar.Text + '%');
          GridPesquisa.DataSource.DataSet.Filtered := True;
        end
      else if CbTipoPesquisa.ItemIndex = 1 then
        begin
          GridPesquisa.DataSource.DataSet.Filtered := False;
          GridPesquisa.DataSource.DataSet.Filter := 'Nome LIKE ' + QuotedStr('%' + EdtPesquisar.Text + '%');
          GridPesquisa.DataSource.DataSet.Filtered := True;
        end;
    end;

  if DataSource.DataSet.RecordCount = 0 then
    GridPesquisa.DataSource := nil;
end;

procedure TFrmConsulta.Selecionar;
begin
  if GridPesquisa.DataSource = nil then
    raise Exception.Create('Nenhum Registro para ser selecionado.');

  EdtCodRetorno.Text := GridPesquisa.DataSource.DataSet.FieldByName('id').AsString;
  EdtNomeRetorno.Text := GridPesquisa.DataSource.DataSet.FieldByName('Nome').AsString;

  FrmConsulta.ModalResult := mrYes;
end;

procedure TFrmConsulta.SetConfig(aDataSource: TDataSource; aObject: TObject);
begin
  FDataSource := aDataSource;
  FObj := aObject;
end;

procedure TFrmConsulta.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

procedure TFrmConsulta.SetObj(const Value: TObject);
begin
  FObj := Value;
end;

end.
