{**
@Abstract(Команды системе логирования для построения лога в виде дерева)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.02.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AMessageConst;

interface

const // Команды системе логирования для построения лога в виде дерева
  //** Создань новую ветку логирования
  lcNewNode = '###<NewNode ParentNodeID=%d>%s</NewNode>';
  lcNewNodeById = '###<NewNode ParentNodeID=%d NodeName="%s" NodeID=%d>%s</NewNode>';
  lcNewNodeByName = '###<NewNode ParentNodeName="%s" NodeName="%s">%s</NewNode>';
  lcChangeStatus = '###<ChangeStatusNode NodeName="%s" NewStatus="%s" />';
  lcChangeStatusById = '###<ChangeStatusNode NodeID=%d NewStatus="%s" />';
  //** Закрыть ветку логирования
  lcCloseNode = '###<CloseNode NodeName="%s" NodeStatus="%s" />';
  //** Добавить сообщение в ветку логирования
  lcAddToNode = '###<AddToNode NodeName="%s">%s</AddToNode>';
  lcAddToNodeById = '###<AddToNode NodeID=%d>%s</AddToNode>';
  lcProcess = '###<ProcessNode NodeName="%s">%d</ProcessNode>';
  lbProcessById = '###<ProcessNode NodeID=%d>%d</ProcessNode>';

implementation

end.
