<?php

$finder = Symfony\Component\Finder\Finder::create()
    ->in([
        __DIR__ . '/tests',
    ])
    ->in(__DIR__)
    ->exclude(['bootstrap', 'storage', 'vendor','docker'])
    ->name('*.php')
    ->name('_ide_helper')
    ->notName('*.blade.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'single_blank_line_before_namespace' => false,
        'no_blank_lines_after_class_opening' => true,
        'blank_line_after_opening_tag' => false,
        'array_syntax' => ['syntax' => 'short'],
        'blank_line_after_namespace' => false,
        'ordered_imports' => ['sort_algorithm' => 'alpha'],
        'no_unused_imports' => true,
        'not_operator_with_successor_space' => false,
        'trailing_comma_in_multiline' => true,
        'phpdoc_scalar' => true,
        'unary_operator_spaces' => false,
        'binary_operator_spaces' => false,
        'single_blank_line_at_eof' => true,
        'blank_line_before_statement' => [
            //'statements' => ['break', 'continue', 'declare', 'return', 'throw', 'try'],
        ],
        'no_extra_blank_lines' => [
            'tokens' => [
                'break',
                'case',
                'continue',
                'curly_brace_block',
                'default',
                'extra',
                'parenthesis_brace_block',
                'return',
                'square_brace_block',
                'switch',
                'throw',
                'use',
            ],
        ],
        'phpdoc_single_line_var_spacing' => true,
        'phpdoc_var_without_name' => true,
        'class_attributes_separation' => [
            'elements' => [
                'method' => 'one',
            ],
        ],
        'method_argument_space' => [
            'on_multiline' => 'ensure_fully_multiline',
            'keep_multiple_spaces_after_comma' => false,
        ],
        'single_trait_insert_per_statement' => true,
    ])
    ->setFinder($finder);
