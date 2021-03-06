<?php

declare(strict_types = 1);

namespace Drupal\Tests\oe_authorisation_syncope\Kernel;

use Drupal\KernelTests\KernelTestBase;
use Drupal\oe_authorisation_syncope\SyncopeClient;

/**
 * Base class the Syncope integration tests.
 *
 * @todo Mock the Syncope client.
 */
class SyncopeTestBase extends KernelTestBase {

  /**
   * The site realm name.
   *
   * @var string
   */
  protected $siteRealm;

  /**
   * Modules to enable.
   *
   * @var array
   */
  protected static $modules = [
    'system',
    'user',
    'oe_authorisation',
    'oe_authorisation_syncope',
  ];

  /**
   * {@inheritdoc}
   */
  protected function setUp(): void {
    $GLOBALS['config']['oe_authorisation_syncope.settings']['credentials'] = [
      'username' => $_ENV['SYNCOPE_USER'],
      'password' => $_ENV['SYNCOPE_PASSWORD'],
    ];
    $GLOBALS['config']['oe_authorisation_syncope.settings']['endpoint'] = $_ENV['SYNCOPE_ENDPOINT'];
    $GLOBALS['config']['oe_authorisation_syncope.settings']['site_realm_name'] = $_ENV['SYNCOPE_REALM_NAME'];

    parent::setUp();

    $this->installEntitySchema('user');
    $this->installConfig([
      'system',
      'oe_authorisation_syncope',
    ]);
    $this->installSchema('system', 'sequences');

    $this->container->get('module_handler')->loadInclude('oe_authorisation_syncope', 'install');
    oe_authorisation_syncope_install();

    $this->installConfig([
      'user',
      'oe_authorisation',
    ]);
    $this->installSchema('user', 'users_data');
  }

  /**
   * Returns the Syncope client.
   *
   * @return \Drupal\oe_authorisation_syncope\SyncopeClient
   *   The Syncope client.
   */
  protected function getClient(): SyncopeClient {
    return $this->container->get('oe_authorisation_syncope.client');
  }

}
