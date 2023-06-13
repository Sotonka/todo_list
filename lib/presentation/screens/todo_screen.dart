import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/icons.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/small_app_bar.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final items = ['Нет', 'Низкий', 'Высокий'];

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeColors.backPrimary,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            leading: InkWell(
              onTap: () {},
              child: AppIcons.close(
                height: 14,
                width: 14,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Text('СОХРАНИТЬ'),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: double.infinity,
                        minWidth: double.infinity,
                        maxHeight: double.infinity,
                        minHeight: 104,
                      ),
                      child: TextFormField(
                        maxLines: 1000,
                        minLines: 1,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: themeColors.backSecondary,
                  ),
                  const SizedBox(height: 28),
                  Text('Важность'),
                  SizedBox(
                    width: 164,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        value: items[0],
                        items: items
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (_) {},
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                          hoverColor: Colors.transparent,
                          filled: false,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text('Сделать до'),
                  Text('date'),
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 22),
                  Text('Удалить'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
