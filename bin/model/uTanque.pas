unit uTanque;

interface

uses CustomAttributesUtils;

type
  TTpCombustivel = (Gasolina, OleoDisel);

  TTanque = class
    private
      FId: Integer;
      FTipoCombustivel: TTpCombustivel;
      FNome: String;
      procedure SetId(const Value: Integer);
      procedure SetNome(const Value: String);
      procedure SetTipoCombustivel(const Value: TTpCombustivel);
    public

      const TpCombustivelString: array[TTpCombustivel] of string = ('Gasolina','�leo Diesel');

      [ColumnInfo('ID', 'C�digo', 70)]
      property Id : Integer read FId write SetId;

      [ColumnInfo('NOME', 'Nome', 170)]
      [NotNull('O Campo nome n�o pode ser nulo.')]
      [MinLength(5, 'O Campo nome deve ter no m�nimo 5 caracteres.')]
      property Nome : String read FNome write SetNome;

      [ColumnInfo('TIPO_COMBUSTIVEL', 'Tipo de Combust�vel', 150)]
      property TipoCombustivel : TTpCombustivel read FTipoCombustivel write SetTipoCombustivel;
  end;

implementation

{ TTanque }

procedure TTanque.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TTanque.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TTanque.SetTipoCombustivel(const Value: TTpCombustivel);
begin
  FTipoCombustivel := Value;
end;

end.
