unit AbastecimentoController;

interface

uses
  Vcl.Forms, ValoresController, Vcl.DBGrids, BombaController, uIAbastecimento,
  uAbastecimento, uBomba;

type

  TAbastecimentoController = class
    private
      FValoresController: TValoresController;
      FAbastecimentoDAO: IAbastecimento;
      FBombaController: TBombaController;
    public
      constructor Create;
      destructor Destroy;override;
      procedure CarregaBombas(aForm: TForm; aGrid: TDBGrid; Nome: String = '');
      procedure CarregaValores(aForm: TForm);
      procedure Salvar(Abastecimento: TAbastecimento);
      function RetornaBombaPorId(Id: Integer):TBomba;
      function CalculaImposto(aValue: Currency): Currency;
  end;

implementation

uses
  RttiUtils, FDAbastecimento;

{ TAbastecimentoController }

constructor TAbastecimentoController.Create;
begin
  FAbastecimentoDAO := TFDAbastecimento.create;
  FValoresController := TValoresController.create;
  FBombaController := TBombaController.Create;
end;

destructor TAbastecimentoController.Destroy;
begin
  inherited;
  FValoresController.Free;
  FBombaController.Free;
end;

function TAbastecimentoController.RetornaBombaPorId(Id: Integer): TBomba;
begin
  Result := FBombaController.RetornaBombaPorId(Id);
end;

procedure TAbastecimentoController.Salvar(Abastecimento: TAbastecimento);
begin
  FAbastecimentoDAO.Salvar(Abastecimento);
end;

function TAbastecimentoController.CalculaImposto(aValue: Currency): Currency;
begin
  Result := aValue * (FValoresController.ValorImposto / 100)
end;

procedure TAbastecimentoController.CarregaBombas(aForm: TForm; aGrid: TDBGrid; Nome: String);
var
  FBomba: TBomba;
begin
  FBomba := TBomba.Create;
  TRttiUtils.DataSourceToGrid(FAbastecimentoDAO.ListaBombasETipos(Nome), aGrid, FBomba);
  FBomba.Free
end;

procedure TAbastecimentoController.CarregaValores(aForm: TForm);
begin
  FValoresController.ListaValores(aForm);
end;

end.
