unit AbastecimentoController;

interface

uses
  Vcl.Forms, ValoresController, Vcl.DBGrids, BombaController, uIAbastecimento;

type

  TAbastecimentoController = class
    private
      ValoresController: TValoresController;
      FAbastecimentoDAO: IAbastecimento;
    public
      constructor Create;
      destructor Destroy;override;
      procedure CarregaBombas(aForm: TForm; aGrid: TDBGrid; Nome: String = '');
      procedure CarregaValores(aForm: TForm);
  end;

implementation

uses
  RttiUtils, FDAbastecimento, uBomba;

{ TAbastecimentoController }

constructor TAbastecimentoController.Create;
begin
  ValoresController := TValoresController.create;
  FAbastecimentoDAO := TFDAbastecimento.create;
end;

destructor TAbastecimentoController.Destroy;
begin
  inherited;
  ValoresController.Free;
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
  ValoresController.ListaValores(aForm);
end;

end.
