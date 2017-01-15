
&НаКлиенте
Процедура ОбновитьИнформациюОПрикрепленныхФайлах()
	
	Если Элементы.ХарактеристикиНоменклатуры.ТекущиеДанные <> Неопределено  тогда
		
		ПрисоединенныеФайлыХарактеристик.Параметры.УстановитьЗначениеПараметра("ХарактеристикаНоменклатуры"		, Элементы.ХарактеристикиНоменклатуры.ТекущиеДанные.Ссылка);
		
	Иначе
		
		ПрисоединенныеФайлыХарактеристик.Параметры.УстановитьЗначениеПараметра("ХарактеристикаНоменклатуры"		, Неопределено);
		
	КонецЕсли;
	
	Если Элементы.ХарактеристикиНоменклатуры.ТекущиеДанные <> Неопределено  тогда
		
		ПрисоединенныеФайлыХарактеристик.Параметры.УстановитьЗначениеПараметра("Номенклатура"		, Элементы.Товары.ТекущиеДанные.Ссылка);
		
	Иначе
		
		ПрисоединенныеФайлыХарактеристик.Параметры.УстановитьЗначениеПараметра("Номенклатура"		, Неопределено);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьКартинку()
	
	Если Элементы.ПрисоединенныеФайлыХарактеристик.ТекущиеДанные <> Неопределено  тогда
		
		АдресКартинки = ПоместитьВоВременноеХранилище(ПолучитьКартинку(Элементы.ПрисоединенныеФайлыХарактеристик.ТекущиеДанные.Ссылка), УникальныйИдентификатор);
		
	Иначе
		
		АдресКартинки = "";
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриАктивизацииСтроки(Элемент)
	
	лНоменклатура = Элементы.Товары.ТекущиеДанные;
	
	Если лНоменклатура <> Неопределено  тогда
		
		ХарактеристикиНоменклатуры.Параметры.УстановитьЗначениеПараметра("Номенклатура"					, лНоменклатура.Ссылка);
		ХарактеристикиНоменклатуры.Параметры.УстановитьЗначениеПараметра("ВидНоменклатуры"				, лНоменклатура.ВидНоменклатуры);
		ХарактеристикиНоменклатуры.Параметры.УстановитьЗначениеПараметра("ИспользованиеХарактеристик"	, лНоменклатура.ИспользованиеХарактеристик);
		
	КонецЕсли;
	
	ОбновитьИнформациюОПрикрепленныхФайлах();
	
	ОбновитьКартинку();

КонецПроцедуры

&НаКлиенте
Процедура ХарактеристикиНоменклатурыПриАктивизацииСтроки(Элемент)
	
	ОбновитьИнформациюОПрикрепленныхФайлах();
	
	ОбновитьКартинку();

КонецПроцедуры

&НаКлиенте
Процедура ПрисоединенныеФайлыХарактеристикПриАктивизацииСтроки(Элемент)
	
	ОбновитьКартинку();

КонецПроцедуры

&НаСервере
Функция ПолучитьКартинку(ПрисоединенныйФайл)
	
	Возврат Справочники.Б_ХарактеристикиНоменклатурыПрисоединенныеФайлы.ПолучитьКартинкуПоПрикрепленномуФайлу(ПрисоединенныйФайл);
	
КонецФункции

&НаКлиенте
Процедура ПрисоединенныеФайлыХарактеристикПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Отказ = Истина;
		
	Если Элементы.ХарактеристикиНоменклатуры.ТекущиеДанные = Неопределено тогда
		//Отказ = Истина;
		Возврат;		
	КонецЕсли;
	
	Если Элементы.Товары.ТекущиеДанные = Неопределено тогда
		//Отказ = Истина;
		Возврат;		
	КонецЕсли;
	
	Если Не ПодключитьРасширениеРаботыСФайлами() Тогда
		Предупреждение(НСтр("ru = 'Для данной операции необходимо установить расширение работы с файлами!'"));
		Возврат;
	КонецЕсли;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = НСтр("ru = 'Укажите файл/картинку'");
	
	Если Диалог.Выбрать() Тогда
		
		лИмяФайла = Диалог.ПолноеИмяФайла;
		
		лФайл = Новый Файл(лИмяФайла);
																											
		ПараметрыФайла = Новый Структура;
		ПараметрыФайла.Вставить("Номенклатура"				, Элементы.Товары.ТекущиеДанные.Ссылка);	
		ПараметрыФайла.Вставить("ХарактеристикаНоменклатуры", Элементы.ХарактеристикиНоменклатуры.ТекущиеДанные.Ссылка);	
		ПараметрыФайла.Вставить("Наименование"				, лФайл.ИмяБезРасширения);	
		ПараметрыФайла.Вставить("ПутьКФайлу"				, лИмяФайла);	
		ПараметрыФайла.Вставить("Расширение"				, лФайл.Расширение);	
		ПараметрыФайла.Вставить("Размер"					, лФайл.Размер());	
		
		лПрисоединенныйФайл = ПолучитьНовыйПрисоединенныйФайл(ПараметрыФайла);
		
		
		ПараметрыФайла = Новый Структура;
		ПараметрыФайла.Вставить("ПрисоединенныйФайл", лПрисоединенныйФайл);	
		ПараметрыФайла.Вставить("Картинка"			, ПоместитьВоВременноеХранилище(Новый Картинка(лИмяФайла), УникальныйИдентификатор));	
		
		ЗаписатьПрисоединенныйФайл(ПараметрыФайла);
		ОбновитьИнформациюОПрикрепленныхФайлах();
		ОбновитьКартинку();

			
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьНовыйПрисоединенныйФайл(ПараметрыФайла)
	
	лПрисоединенныйФайл = Справочники.Б_ХарактеристикиНоменклатурыПрисоединенныеФайлы.СоздатьНовыйПрисоединенныйФайл(ПараметрыФайла);
	
	Возврат лПрисоединенныйФайл;
	
КонецФункции

&НаСервере
Процедура ЗаписатьПрисоединенныйФайл(ПараметрыФайла)
	
	Справочники.Б_ХарактеристикиНоменклатурыПрисоединенныеФайлы.ЗаписатьПрисоединенныйФайл(ПараметрыФайла);
	
КонецПроцедуры







