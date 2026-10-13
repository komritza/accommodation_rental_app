import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../listing_detail/listing_detail_labels.dart';
import '../listings/listings_providers.dart';
import 'host_edit_listing_error_mapper.dart';
import 'host_edit_listing_providers.dart';
import 'host_edit_listing_state.dart';
import 'host_edit_listing_validators.dart';

class HostEditListingScreen extends ConsumerStatefulWidget {
  const HostEditListingScreen({
    super.key,
    required this.listingId,
    required this.onSaved,
  });

  final String listingId;
  final VoidCallback onSaved;

  @override
  ConsumerState<HostEditListingScreen> createState() =>
      _HostEditListingScreenState();
}

class _HostEditListingScreenState extends ConsumerState<HostEditListingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _cleaningFeeController = TextEditingController();
  final _maxGuestsController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bedsController = TextEditingController();
  final _bathroomsController = TextEditingController();

  bool _controllersInitialized = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _cleaningFeeController.dispose();
    _maxGuestsController.dispose();
    _bedroomsController.dispose();
    _bedsController.dispose();
    _bathroomsController.dispose();
    super.dispose();
  }

  void _initializeControllers(HostEditListingState state) {
    if (_controllersInitialized) return;

    _titleController.text = state.title;
    _descriptionController.text = state.description;
    _priceController.text = state.pricePerNight.toString();
    _cleaningFeeController.text = state.cleaningFee.toString();
    _maxGuestsController.text = state.maxGuests.toString();
    _bedroomsController.text = state.bedrooms.toString();
    _bedsController.text = state.beds.toString();
    _bathroomsController.text = state.bathrooms.toString();

    _controllersInitialized = true;
  }

  HostEditListingControllerProvider _provider(BuildContext context) {
    return hostEditListingControllerProvider(
      widget.listingId,
      language: Localizations.localeOf(context).languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = _provider(context);
    final editState = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.hostEditListingTitle)),
      body: editState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.hostEditListingLoadError),
                const SizedBox(height: AppSpacing.md),
                FilledButton(
                  onPressed: () => ref.invalidate(provider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (state) {
          _initializeControllers(state);

          return Column(
            children: [
              Expanded(child: _buildForm(context, state, provider, l10n)),
              _buildSaveBar(context, state, provider, l10n),
            ],
          );
        },
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    HostEditListingState state,
    HostEditListingControllerProvider provider,
    AppLocalizations l10n,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final controller = ref.read(provider.notifier);
    final facets = ref.watch(listingFacetsProvider).value;

    final propertyTypes = {
      ...?facets?.propertyTypes,
      state.propertyType,
    }.toList();
    final amenities = {...?facets?.amenities, ...state.amenities}.toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayoutTokens.contentMaxWidth,
          ),
          child: Form(
            key: _formKey,
            // An invalid number never reaches the state, so the save button
            // can stay disabled; the error has to show while typing.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.hostEditListingGeneralSection,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _textField(
                  controller: _titleController,
                  label: l10n.hostEditListingTitleField,
                  onChanged: controller.updateTitle,
                ),
                const SizedBox(height: AppSpacing.md),
                _textField(
                  controller: _descriptionController,
                  label: l10n.hostEditListingDescriptionField,
                  onChanged: controller.updateDescription,
                  maxLines: 4,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: state.propertyType,
                  decoration: InputDecoration(
                    labelText: l10n.hostEditListingPropertyTypeField,
                  ),
                  items: [
                    for (final type in propertyTypes)
                      DropdownMenuItem(
                        value: type,
                        child: Text(type.humanized),
                      ),
                  ],
                  onChanged: state.isSaving
                      ? null
                      : (type) {
                          if (type != null) controller.updatePropertyType(type);
                        },
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.hostEditListingPricingSection,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _priceController,
                  label: l10n.hostEditListingPricePerNightField,
                  onChanged: controller.updatePricePerNight,
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _cleaningFeeController,
                  label: l10n.hostEditListingCleaningFeeField,
                  onChanged: controller.updateCleaningFee,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.hostEditListingCapacitySection,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _maxGuestsController,
                  label: l10n.hostEditListingMaxGuestsField,
                  wholeNumber: true,
                  min: 1,
                  onChanged: (value) =>
                      controller.updateMaxGuests(value.toInt()),
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _bedroomsController,
                  label: l10n.hostEditListingBedroomsField,
                  wholeNumber: true,
                  onChanged: (value) =>
                      controller.updateBedrooms(value.toInt()),
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _bedsController,
                  label: l10n.hostEditListingBedsField,
                  wholeNumber: true,
                  onChanged: (value) => controller.updateBeds(value.toInt()),
                ),
                const SizedBox(height: AppSpacing.md),
                _numberField(
                  controller: _bathroomsController,
                  label: l10n.hostEditListingBathroomsField,
                  wholeNumber: true,
                  onChanged: (value) =>
                      controller.updateBathrooms(value.toInt()),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.hostEditListingAmenitiesSection,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    for (final amenity in amenities)
                      FilterChip(
                        label: Text(amenityLabel(l10n, amenity)),
                        selected: state.amenities.contains(amenity),
                        onSelected: state.isSaving
                            ? null
                            : (_) => controller.toggleAmenity(amenity),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveBar(
    BuildContext context,
    HostEditListingState state,
    HostEditListingControllerProvider provider,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final saveFailure = state.saveFailure;

    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayoutTokens.contentMaxWidth,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (saveFailure != null) ...[
                  Text(
                    localizedHostEditListingError(l10n, saveFailure),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                FilledButton(
                  onPressed: state.isSaving || !state.hasChanges
                      ? null
                      : () => _save(provider),
                  child: state.isSaving
                      ? const SizedBox.square(
                          dimension: AppIconSizes.md,
                          child: CircularProgressIndicator(
                            strokeWidth: AppBorderWidths.focused,
                          ),
                        )
                      : Text(l10n.hostEditListingSaveButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      validator: (value) => validateRequiredText(l10n, value),
    );
  }

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<num> onChanged,
    bool wholeNumber = false,
    int min = 0,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.numberWithOptions(decimal: !wholeNumber),
      onChanged: (value) {
        final parsed = parseListingNumber(value, wholeNumber: wholeNumber);
        if (parsed != null) onChanged(parsed);
      },
      validator: (value) => validateListingNumber(
        l10n,
        value,
        wholeNumber: wholeNumber,
        min: min,
      ),
    );
  }

  Future<void> _save(HostEditListingControllerProvider provider) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final saved = await ref.read(provider.notifier).save();
    if (mounted && saved) widget.onSaved();
  }
}
