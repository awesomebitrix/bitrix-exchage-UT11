&НаКлиенте
Процедура ОткрытьФормуВыполненияОперации(ОписаниеОперации) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОписаниеОперации", ОписаниеОперации);	
	ОтветФормы = Неопределено;
		
	//ОткрытьФорму("ОбщаяФорма.Б_ФормаВыполненияОперации", ПараметрыФормы, ,"ОкноСостояния",,,, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
		
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФормуВыполненияОперации() Экспорт
	Оповестить("Закрыть", ,"ОкноСостояния");
КонецПроцедуры



