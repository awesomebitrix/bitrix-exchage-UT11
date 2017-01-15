
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЭтоАдресВременногоХранилища(Параметры.АдресНастроекОбмена) Тогда
		
		АдресНастроекОбмена = Параметры.АдресНастроекОбмена;
		
		НастройкиОбмена 	= ПолучитьИзВременногоХранилища(АдресНастроекОбмена);
		
		ВыгрузкаКартЛояльности 			= ПланыОбмена.Б_ОбменССайтом.ПолучитьЗначениеКлючаСтруктурыНастроек(НастройкиОбмена.КартыЛояльности, "ВыгрузкаКартЛояльности");
		КоличествоКартЛояльностиВПакете = ПланыОбмена.Б_ОбменССайтом.ПолучитьЗначениеКлючаСтруктурыНастроек(НастройкиОбмена.КартыЛояльности, "КоличествоКартЛояльностиВПакете");
		
		НастройкиКомпоновкиДанныхКартЛояльности = ПланыОбмена.Б_ОбменССайтом.ПолучитьЗначениеКлючаСтруктурыНастроек(НастройкиОбмена.КартыЛояльности, "НастройкиКомпоновкиДанныхКартЛояльности");
					
		СтруктураССхемамиК = Б_ОбменССайтомСервер.ПолучитьСтруктуруСхемКомпоновки();
			
		АдресСхемы = ПоместитьВоВременноеХранилище(СтруктураССхемамиК.ДисконтныеКарты, УникальныйИдентификатор);
		КомпоновщикНастроекКомпоновкиДанныхКартЛояльности.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы)); 
		КомпоновщикНастроекКомпоновкиДанныхКартЛояльности.ЗагрузитьНастройки(НастройкиКомпоновкиДанныхКартЛояльности);
		КомпоновщикНастроекКомпоновкиДанныхКартЛояльности.Восстановить(СпособВосстановленияНастроекКомпоновкиДанных.ПроверятьДоступность);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПроверитьИЗакрыть(Команда)
	
	Если ЭтаФорма.Модифицированность тогда
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ПослеЗакрытияВопроса", ЭтаФорма, Параметры), "Были именены настройке на форме. Закрыть форму настроек без сохранения?", РежимДиалогаВопрос.ДаНет);
		
	Иначе
		ЭтаФорма.Закрыть();	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопроса(Результат, Параметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЭтаФорма.Закрыть();	
    КонецЕсли;

КонецПроцедуры
////////////////////////////////////////////////////////////////////////////////

&НаКлиенте
Процедура Применить(Команда)
	
	Закрыть(ПрименитьНаСервере());
	
КонецПроцедуры

&НаСервере
Функция ПрименитьНаСервере()
	
	Настройки = ПолучитьИзВременногоХранилища(АдресНастроекОбмена);

	Настройки.КартыЛояльности.КоличествоКартЛояльностиВПакете			= КоличествоКартЛояльностиВПакете;	
	Настройки.КартыЛояльности.НастройкиКомпоновкиДанныхКартЛояльности	= КомпоновщикНастроекКомпоновкиДанныхКартЛояльности.ПолучитьНастройки();
	
	лАдресНастроекОбмена = ПоместитьВоВременноеХранилище(Настройки, УникальныйИдентификатор);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресНастроекОбмена"	, лАдресНастроекОбмена);

	Возврат ПараметрыФормы;
	 
КонецФункции

#КонецОбласти
