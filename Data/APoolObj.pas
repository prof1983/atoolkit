{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(04.06.2012)
@LastMod(04.06.2012)
@Version(0.0.5)
}
unit APoolObj;

interface

type
  TPoolType = (pNone, pUnknown, pNetwork, pFile, pMemory);

type
  TAPool = class
  public
    Name: WideString;
    Title: WideString;
  end;

type
  TAMemoryPool = class(TAPool)
  end;

type
  TANetworkPool = class(TAPool)
  end;

type
  TAFilePool = class(TAPool)
  end;

implementation

end.
